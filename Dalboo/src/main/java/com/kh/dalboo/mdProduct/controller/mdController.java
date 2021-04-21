package com.kh.dalboo.mdProduct.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.dalboo.common.PageInfo;
import com.kh.dalboo.common.Pagination;
import com.kh.dalboo.mdProduct.model.exception.MdException;
import com.kh.dalboo.mdProduct.model.service.MdService;
import com.kh.dalboo.mdProduct.model.vo.Cart;
import com.kh.dalboo.mdProduct.model.vo.Files;
import com.kh.dalboo.mdProduct.model.vo.MdOrder;
import com.kh.dalboo.mdProduct.model.vo.MdProduct;
import com.kh.dalboo.member.model.vo.Address;
import com.kh.dalboo.member.model.vo.Member;
import com.kh.dalboo.member.model.vo.PointHistory;


@SessionAttributes("loginUser")

@Controller
public class mdController {

	
	@Autowired
	private MdService mdService;
	
	@RequestMapping("mdMain.md")
	public ModelAndView mdMain(@RequestParam(value="page", required=false) Integer page, ModelAndView mv, @RequestParam("mdCategory") String mdCategory) {
		//Md메인 페이지 
		
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		//전체 개시물 개수
		int listCount = mdService.getListCount(mdCategory);
		
		//페이징 계산
		PageInfo pi = Pagination.getPageEightInfo(currentPage, listCount);
		
		//같은 selectList로 보내서 MdList를 가져온다.
		ArrayList<MdProduct> mdlist = mdService.selectList(1, mdCategory, pi);
		ArrayList<Files> flist = mdService.selectList(2, mdCategory, pi);
		
		if(mdlist != null) {
			mv.addObject("mdlist", mdlist).addObject("flist", flist).addObject("pi", pi).addObject("mdCategory", mdCategory).setViewName("md_list");
		} else {
			throw new MdException("MD상품 조회 실패");
		}
		return mv;
	}

	@RequestMapping("mdInsertView.md")
	public String mdInsertView() {
		//MD추가하는 뷰
		return "mdInsertView";
	}
	
	@RequestMapping("insert.md")
	public String mdInsert(@ModelAttribute MdProduct md, @RequestParam("thumbnailImg") MultipartFile[] upFile, HttpServletRequest request) {
		//MD추가 처리
		
        ArrayList<Files> files = new ArrayList<Files>();
        
        int i = 0;
        
        for(MultipartFile f : upFile) {
        	
			String root = request.getSession().getServletContext().getRealPath("resources");
			String savePath = root + "\\mdUploadFiles";
			
			File folder = new File(savePath);
			if(!folder.exists()) {
				//폴더 없으면 새 폴더
				folder.mkdirs();
			}
			//저장 시 바뀐 이름 넣기
			String originalFileName = f.getOriginalFilename();
			
			String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			//파일 rename
			UUID uuid = UUID.randomUUID();
			String renameFileName = uuid.toString() + extension;
			
					
			//완성 경로
			String renamePath = folder + "\\" + renameFileName;
			
			try {
				f.transferTo(new File(renamePath));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) { 
				e.printStackTrace();
			}
		
			Files fi = new Files();
			fi.setChangeName(renameFileName);
			fi.setOriginName(originalFileName);
			fi.setFilePath(renamePath);
			
			//인덱스 이용해서 photoLevel 설정
			if(i == 0) {
				fi.setPhotoLevel(0);
			} else {
				fi.setPhotoLevel(1);
			}
			
			files.add(fi);
			i++;
		}	
        
		int result = mdService.insertMD(md, files);

		if(result > 0) {
			return "mdInsertView";
		} else {
			throw new MdException("상품 추가 실패");
		}
	}
	
	
	//md상품 상세조회
	@RequestMapping("mdDetail.md")
	public ModelAndView mdDetail(@RequestParam("mdNum") int mdNum, ModelAndView mv) {
		
		MdProduct md = mdService.selectMdDetail(mdNum);
		ArrayList<Files> f = mdService.selecMdFileDetial(mdNum);
		
		if(md != null && f != null) {
			mv.addObject("md", md).addObject("f", f).setViewName("md_detail");;
		} else {
			throw new MdException("상세조회 실패");
		}
		
		return mv;
	}
	
	
	//md상품 수정View
	@RequestMapping("mdModifyView.md")
	public ModelAndView mdModify(@RequestParam("mdNum") int mdNum, ModelAndView mv) {
		
		
		MdProduct md = mdService.selectMdDetail(mdNum);
		ArrayList<Files> f = mdService.selecMdFileDetial(mdNum);
		
		
		if(md != null && f != null) {
			mv.addObject("md", md).addObject("f", f).setViewName("md_modifyView");
		} else {
			throw new MdException("수정 조회 실패");
		}
		
		return mv;
	}
	
	
	//MD상품 수정
	@RequestMapping("mdModify.md")
	public String mdModify(@ModelAttribute MdProduct md,@RequestParam("reloadImg") MultipartFile[] reloadFile, @RequestParam("fileNum") int[] fileNum,
			@RequestParam("filePath") String[] filePath, HttpServletRequest request) {

		//이전 페이지로 보내기위해 md값 받아오기
		int mdNum = md.getMdNum();
		
		ArrayList<Files> files = new ArrayList<Files>();
		int result = 0;
		int i = 0;
		
		Files fi = new Files();
		
		for (MultipartFile f : reloadFile) {

			if (f.getSize() == 0) {
				// 파일 없으면 그냥 게시글 수정만하기
				result = mdService.modifyMd(md);
			} else {
				// 파일이 존재한다면
				

				String root = request.getSession().getServletContext().getRealPath("resources");
				String savePath = root + "\\mdUploadFiles";
				
				
				//저장된 파일 있으면 삭제
				File file = new File(savePath + "\\" + filePath[i]);
				if(file.exists()) { 
					file.delete(); 
				}
				
				File folder = new File(savePath);
				//저장 시 바뀐 이름 넣기
				String originalFileName = f.getOriginalFilename();
				
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
				
				UUID uuid = UUID.randomUUID();
				String renameFileName = uuid.toString() + extension;
				
				//완성 경로
				String renamePath = folder + "\\" + renameFileName;
			
				try {
					f.transferTo(new File(renamePath));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				fi.setFileNum(fileNum[i]);
				fi.setChangeName(renameFileName);
				fi.setOriginName(originalFileName);
				fi.setFilePath(renamePath);
				fi.setBoardNum(md.getMdNum());

				// 인덱스 이용해서 photoLevel 설정
				if (i == 0) {
					fi.setPhotoLevel(0);
				} else {
					fi.setPhotoLevel(1);
				}

				files.add(fi);
				i++;
			}

			result = mdService.modifyMdFile(md, files, fileNum);
		}

		if (result > 0) {
			return "redirect:mdDetail.md?mdNum="+mdNum;
		} else {
			throw new MdException("상품 수정 실패");

		}
	}
	
	
	
	//MD상품 삭제
	@RequestMapping("mdDelete.md")
	public ModelAndView mdDelete(@RequestParam("mdNum") int mdNum, ModelAndView mv) {
		//status만 n으로 해놓으니 사진파일 삭제는 안함!
		
		int result = mdService.deleteMD(mdNum);
		
		if(result > 0) {
			
			String path = "alert(\"삭제가 완료되었습니다.\");\r\n" + 
					"			location.href='mdMain.md?mdCategory=머그컵';";
			
			mv.addObject("path", path).setViewName("../member/alert");
			
		} else {
			throw new MdException("삭제 실패");
		}
		
		return mv;
	}
	
	
	//md상품 정렬
	@RequestMapping("mdPopList.md")
	public ModelAndView popList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv,
				@RequestParam("mdCategory") String mdCategory, HttpServletRequest request, HttpServletResponse response) {
		
		//인기순으로 정렬
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		
		//전체 개시물 개수
		int listCount = mdService.getListCount(mdCategory);
		
		//페이징 계산
		PageInfo pi = Pagination.getPageEightInfo(currentPage, listCount);
		
		ArrayList<MdProduct> mdlist = mdService.selectPopList(mdCategory, pi);
		//파일은 위에서 사용한 selectList를 다시 사용한다.
		ArrayList<Files> flist = mdService.selectList(2, mdCategory, pi);
		
		if(mdlist != null) {
			mv.addObject("mdlist", mdlist).addObject("flist", flist).addObject("pi", pi).addObject("mdCategory", mdCategory).setViewName("mdPopList");
		} else {
			throw new MdException("MD상품 조회 실패");
		}
		return mv;
	}

	
	
	//장바구니
	@RequestMapping("myCartList.md")
	public ModelAndView myCartList(HttpSession session, ModelAndView mv) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		ArrayList<Cart> clist = mdService.selectCartList(id);
		
		//ArrayList<Files> f = mdService.selectCartFile(id);
		ArrayList<Files> f = new ArrayList<Files>();
		for(int i=0; i<clist.size(); i++) {
			int mdNum = clist.get(i).getMdNum();
			f.addAll(mdService.selectMdOrderFiles(mdNum));	//이름이 mdOrderFiles인 이유는 수정해서,,, 아래거로 사용한 것 같은 값을 넘겨서 이렇게씀..
		}
		
		//비어있는 로직은 view에서 처리한다.
		mv.addObject("clist", clist).addObject("f", f).setViewName("myCartList");
		
		return mv; 
		
	}

	//장바구니 추가
	@RequestMapping("mdCartInsert.md")
	@ResponseBody
	public int mdCartUpdate(@RequestParam("amount") int amount, @RequestParam("mdNum") int mdNum, 
					@RequestParam("mdName") String mdName, @RequestParam("price") int price, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		Cart c = new Cart();
		c.setCartAmount(amount);
		c.setMdNum(mdNum);
		c.setmId(id);
		c.setCartAmount(amount);	//한 번에 넣을 수 있는 양은 남아있는 재고량까지이다.
		c.setMdName(mdName);
		c.setMdPrice(price);

		int result = mdService.insertCart(c); 
		
		if(result > 0) {
			return result;
		} else {
			throw new MdException("장바구니 상품담기 실패");
		}		
	}
	
	//카트 개수 수정 뷰
	@RequestMapping("cartRotnModifyView.md")
	public ModelAndView cartRotnModify(@RequestParam("cartNum") int cartNum, ModelAndView mv) {
		Cart c = mdService.selectCartNum(cartNum);
		int mdNum = c.getMdNum();
		
		MdProduct md = mdService.selectMdDetail(mdNum);
		int mdStock = md.getMdStock();
		
		//mdDetail에서 사용한 detail파일을 가져온다.
		ArrayList<Files> f = mdService.selecMdFileDetial(mdNum);
		
		mv.addObject("c", c).addObject("f", f).addObject("mdStock", mdStock).setViewName("cartRotnModifyView");
		
		return mv;
	}
	
	//카트 개수 수정
	@RequestMapping("cartRotnModify.md")
	public ModelAndView cartRotnModify(@ModelAttribute Cart c, ModelAndView mv) {
		
		int result = mdService.modifyCartRotn(c);
			
		//윈도우 창을 닫고 부모창을 reload할 수 있도록
		String path = "window.close(); opener.location.reload();";
		
		if(result > 0) {
			mv.addObject("path", path).setViewName("../member/alert");
		} else {
			throw new MdException("장바구니 수정 실패");
		}
		return mv;
	}
	
	//카트 삭제
	@RequestMapping("deleteCart.md")
	public ModelAndView deleteCart(ModelAndView mv, @RequestParam("chkArr") int[] chkArr) {
		
		Cart c = new Cart();
		int result =0;
		for(int i=0; i<chkArr.length; i++) {
			c.setCartNum(chkArr[i]);
			result = mdService.deleteCart(c);
		}
		
		//카트는 status따로 없이 바로 db에서 삭제한다.
		
		if(result > 0) {
			mv.setViewName("redirect:myCartList.md");
		} else {
			throw new MdException("장바구니 삭제 실패");			
		}
		return mv;
	}
	
	
	//체크박스 구매상품 눌렀을 때
	@RequestMapping("cartsBuyView.md")
	public ModelAndView cartsBuyView(@RequestParam("chkArr") String chkArr, HttpSession session, ModelAndView mv) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String id = loginUser.getId();
		
		ArrayList<Cart> clist = mdService.selectCartCheckList(chkArr);
		
		ArrayList<Files> flist = new ArrayList<Files>(); 
		for(int i=0; i<clist.size(); i++) {
			int mdNum = clist.get(i).getMdNum();
			flist.addAll(mdService.selectMdOrderFiles(mdNum));
			
		}
		
		ArrayList<Address> adlist = mdService.selectAddressList(id);
		
		//총 가격을 넘긴다.
		int totalPrice = 0;
		
		//개수
		for(Cart c : clist) {
			
			int amount = c.getCartAmount();
			int price = c.getMdPrice();
			
			totalPrice += amount * price;
		}
		
		
		mv.addObject("clist", clist).addObject("flist", flist).addObject("adlist", adlist).addObject("totalPrice", totalPrice).setViewName("cartBuyView");
		return mv;
	}
		
	
	
	
	
	
	
	
	
	
	//결제하는 곳 안에서 저장된 배송지 선택하는 뷰
	@RequestMapping("choseaddress.md")
	public ModelAndView chooseAddress(ModelAndView mv, HttpSession session) {
		//기본 배송지 선택하는 뷰
		Member loginUser = (Member)session.getAttribute("loginUser");
		String mId = loginUser.getId();
		
		//member에서 사용했던 memberMapper를 사용한다.
		ArrayList<Address> adlist = mdService.selectAddressList(mId);
		
		mv.addObject("adlist", adlist).setViewName("chooseAddressView");;
		
		return mv;
	}

	
	//detail에서 상품 구매 시 이동, 카트가 필요없기에 바로 결제 진행한다.
	@RequestMapping("md_buy.md")
	public ModelAndView md_buy(@RequestParam("mdNum") int mdNum, @RequestParam("amount") int amount, HttpSession session, ModelAndView mv) {
		
		String id = ((Member)session.getAttribute("loginUser")).getId();
		
		MdProduct md = mdService.selectMdDetail(mdNum);
		ArrayList<Files> f = mdService.selecMdFileDetial(mdNum);
		ArrayList<Address> adlist = mdService.selectAddressList(id);		
		
		mv.addObject("md", md).addObject("f", f).addObject("adlist", adlist).addObject("amount", amount).setViewName("md_buy");
		
		return mv;
	}
	
	//디테일에서 결제 시 완료
	@RequestMapping("buyEndMd.md")
	public ModelAndView buyEndMd(@ModelAttribute MdOrder mo, @RequestParam("mdNum") int mdNum, @RequestParam("mdAmount") int mdAmount, 
									@RequestParam("memberUsePoint") int memberUsePoint, @RequestParam("mdPrice") int mdPrice, 
									HttpSession session, ModelAndView mv, Model model) {

		Member member = (Member)session.getAttribute("loginUser");
		String mId = member.getId();
		
		//MdOrder에 값 넣어주기
		mo.setmId(mId);
		mo.setMdNum(mdNum);
		mo.setMdAmount(mdAmount);
		
		//1을 넘기는 이유는 2는 장바구니 삭제까지 하기 때문!... detail에서 넘어갈 때는 장바구니 거치지 않기 때문에 그냥 넘어간다!
		int result = mdService.insertMdOrder(mo, 1);
		
		//포인트 사용
		int originPoint = member.getPoint();			//기존 포인트
		int changePoint = memberUsePoint;				//사용 포인트
		
		//포인트 적립 
		int discountPoint = (int)(mo.getTotalPrice() * 0.1);		//적립 포인트 (10%적립)
		int afterPoint2 = (originPoint - memberUsePoint) + discountPoint;	// 기존 포인트 - 사용 포인트 + 적립 포인트
																			//member의 포인트 변경 

		//먼저 사용한 내역 추가
		PointHistory ph = new PointHistory();
		int result2 = 0;
		if(changePoint > 0) {
			ph.setmId(mId);
			ph.setEvent("MD상품 결제 시 사용");
			ph.setConditions(1);							//사용 내역 1
			ph.setOriginPoint(originPoint);					//기존 포인트
			ph.setChangePoint(changePoint);					//사용 포인트
			ph.setAfterPoint(originPoint - changePoint);	//기존 - 사용
			
			result2 = mdService.insertPointHistory(ph);
		}
		
		//적립된 내역 추가
		PointHistory phSaving = new PointHistory();
		int result3 = 0;
		if(discountPoint > 0) {
			phSaving.setmId(mId);							
			phSaving.setEvent("MD상품 구매 적립");				//적립 이벤트 내용
			phSaving.setConditions(0);						//0:추가 / 1: 사용
			phSaving.setOriginPoint(ph.getAfterPoint());	//기존 포인트
			phSaving.setChangePoint(discountPoint);			//변화한 포인트 (= 적립 내역)
			phSaving.setAfterPoint(afterPoint2);
			
			result3 = mdService.insertPointHistory(phSaving);
			
		}
		
		//멤버 업데이트mId, afterPoint2
		member.setId(mId);
		member.setPoint(afterPoint2);
		result3 = mdService.updateMemberPoint(member);
		String path = "		var bool = window.confirm(\"달보드레를 이용해주셔서 감사합니다.\" + \"\\n\" + \"주문 목록을 확인하시겠습니까?\");\r\n" + 
				"		\r\n" + 
				"		if(bool){\r\n" + 
				"			location.href='mdOrderListView.md';\r\n" + 
				"		} else{\r\n" + 
				"			location.href='mdMain.md?mdCategory=머그컵';\r\n" + 
				"		}";
		
		if(result > 0 &&  result3 > 0) {
			model.addAttribute("loginUser", member);
			mv.addObject("path", path).setViewName("../member/alert");
		} else if(result < 1){
			throw new MdException("주문 내역 삽입 실패");
		} else if(result3 < 1) {
			throw new MdException("포인트 적립내역 삽입 실패");
		}
		return mv;
	}
	
	//장바구니 결제 시 완료
	@RequestMapping("buyEndMdCarts.md")
	public ModelAndView buyEndMdCarts(@ModelAttribute MdOrder mo , @RequestParam("mdNum") int[] mdNum, @RequestParam("cartAmount") int[] cartAmount,
										@RequestParam("memberUsePoint") int memberUsePoint, @RequestParam("mdPrice") int mdPrice, 
										HttpSession session, ModelAndView mv, Model model) {
		//상품 받은 후 장바구니 삭제하고 mdOrder에 올라가야한다.
		
		Member member = (Member)session.getAttribute("loginUser");
		String mId = member.getId();
		
		int result =0;
		for(int i =0; i <mdNum.length; i++) {
			
			mo.setMdNum(mdNum[i]);
			mo.setMdAmount(cartAmount[i]);
			mo.setmId(mId);
			
			//2넘기니까 장바구니 삭제된다!
			result = mdService.insertMdOrder(mo, 2);
		}
		
		
		
		//포인트 사용
		int originPoint = member.getPoint();			//기존 포인트
		int changePoint = memberUsePoint;				//사용 포인트
		
		//포인트 적립 
		int discountPoint = (int)(mo.getTotalPrice() * 0.1);		//적립 포인트 (10%적립)
		int afterPoint2 = (originPoint - memberUsePoint) + discountPoint;	// 기존 포인트 - 사용 포인트 + 적립 포인트
																			//member의 포인트 변경 

		//먼저 사용한 내역 추가
		PointHistory ph = new PointHistory();
		int result2 = 0;
		if(changePoint > 0) {
			ph.setmId(mId);
			ph.setEvent("MD상품 결제 시 사용");
			ph.setConditions(1);							//사용 내역 1
			ph.setOriginPoint(originPoint);					//기존 포인트
			ph.setChangePoint(changePoint);					//사용 포인트
			ph.setAfterPoint(originPoint - changePoint);	//기존 - 사용
			
			result2 = mdService.insertPointHistory(ph);
		}
		
		//적립된 내역 추가
		PointHistory phSaving = new PointHistory();
		int result3 = 0;
		if(discountPoint > 0) {
			phSaving.setmId(mId);							
			phSaving.setEvent("MD상품 구매 적립");				//적립 이벤트 내용
			phSaving.setConditions(0);						//0:추가 / 1: 사용
			phSaving.setOriginPoint(ph.getAfterPoint());	//기존 포인트
			phSaving.setChangePoint(discountPoint);			//변화한 포인트 (= 적립 내역)
			phSaving.setAfterPoint(afterPoint2);
			
			result3 = mdService.insertPointHistory(phSaving);		
		}
		
		//멤버 업데이트mId, afterPoint2
		
		member.setId(mId);
		member.setPoint(afterPoint2);
		result3 = mdService.updateMemberPoint(member);
		String path = "		var bool = window.confirm(\"달보드레를 이용해주셔서 감사합니다.\" + \"\\n\" + \"주문 목록을 확인하시겠습니까?\");\r\n" + 
				"		\r\n" + 
				"		if(bool){\r\n" + 
				"			location.href='mdOrderListView.md';\r\n" + 
				"		} else{\r\n" + 
				"			location.href='mdMain.md?mdCategory=머그컵';\r\n" + 
				"		}"; 
		if(result > 0 && result3 > 0) {
			model.addAttribute("loginUser", member);
			mv.addObject("path", path).setViewName("../member/alert");
		} else if(result < 1){
			throw new MdException("주문 내역 삽입 실패");
		} else if(result3 < 1) {
			throw new MdException("포인트 적립 삽입 실패");
		}
		
		return mv;
	}
	
	
	
	//md상품주문 조회 뷰
	@RequestMapping("mdOrderListView.md")
	public ModelAndView mdBuyCompleteView(@RequestParam(value="page", required=false) Integer page, HttpSession session, ModelAndView mv) {
		
		String mId = ((Member)session.getAttribute("loginUser")).getId();
		
		//molist페이징 처리
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}
		//개시물 개수
		int listCount = mdService.getMdOrderListCount(mId);
		
		//페이징 계산
		PageInfo pi = Pagination.getFivePageInfo(currentPage, listCount);
		
		ArrayList<MdOrder> molist = mdService.selectMdOrder(mId, pi);
		
		ArrayList<MdProduct> mdlist = new ArrayList<MdProduct>();
		ArrayList<Files> flist = new ArrayList<Files>();
	
		for(int i=0; i<molist.size(); i++) {
			mdlist.addAll(mdService.selectMdOrderProduct(molist.get(i).getMdNum()));
			flist.addAll(mdService.selectMdOrderFiles(molist.get(i).getMdNum()));
			
		}
		//개수
		int ship = mdService.countMdShipStatus(mId, 1);
		int end = mdService.countMdShipStatus(mId, 2);
		
		mv.addObject("molist", molist).addObject("pi", pi).addObject("mdlist", mdlist)
			.addObject("flist", flist).addObject("ship", ship).addObject("end", end).setViewName("mdOrderList");
		
		return mv;
	}
	
	
	
	@RequestMapping("mdShipManagement.md")
	public ModelAndView mdShipManagement(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {

		//molist페이징 처리
		int currentPage = 1;
		
		if(page != null) {
			currentPage = page;
		}		
		//개시물 개수
		int listCount = mdService.getMdOrderManagementListCount();
		
		//페이징 계산
		PageInfo pi = Pagination.getFivePageInfo(currentPage, listCount);
		
		ArrayList<MdOrder> molist = mdService.selectMdShipManagement(pi);
		
		
		ArrayList<MdProduct> mdlist = new ArrayList<MdProduct>();
		ArrayList<Files> flist = new ArrayList<Files>();
	
		for(int i=0; i<molist.size(); i++) {
			mdlist.addAll(mdService.selectMdOrderProduct(molist.get(i).getMdNum()));
			flist.addAll(mdService.selectMdOrderFiles(molist.get(i).getMdNum()));
		}
		
		mv.addObject("molist", molist).addObject("pi", pi).addObject("mdlist", mdlist).addObject("flist", flist).setViewName("mdShipManagement");
		
		return mv;
	}
	
	
	//배송 완료로 바꾸기
	@RequestMapping("shipEnd.md")
	public String shipEnd(@RequestParam("chkArr") int[] chkArr, HttpServletRequest request) {
		MdOrder mo = new MdOrder();

		int result = 0;
		for(int i=0; i<chkArr.length; i++) {
			mo.setMdOrderNum(chkArr[i]);
			
			result = mdService.shipEnd(mo);
		}
		
	    String referer = request.getHeader("Referer");
		
		if(result > 0) {
			return "redirect:"+ referer;
		} else {
			throw new MdException("배송 완료 실패");
		}
		
	}
	
	//구매 완료로 바꾸기
	@RequestMapping("orderEnd.md")
	public String orderEnd(@RequestParam("chkArr") int[] chkArr, HttpServletRequest request) {
		MdOrder mo = new MdOrder();
		
		int result = 0;
		for(int i=0; i<chkArr.length; i++) {
			mo.setMdOrderNum(chkArr[i]);
			
			result = mdService.orderEnd(mo);
		}
		
		String referer = request.getHeader("Referer");
		
		if(result > 0) {
			return "redirect:"+ referer;
		} else {
			throw new MdException("배송 완료 실패");
		}
		
	}
	
	
	//주문 중인 것만 불러오기
	@RequestMapping("orderIng.md")
	public void orderIng(HttpServletResponse response) {
		
		
		ArrayList<MdOrder> molist = mdService.selectOrderIng(0);
		
		ArrayList<MdProduct> mdlist = new ArrayList<MdProduct>();
		ArrayList<Files> flist = new ArrayList<Files>();
	
		for(int i=0; i<molist.size(); i++) {
			mdlist.addAll(mdService.selectMdOrderProduct(molist.get(i).getMdNum()));
			flist.addAll(mdService.selectMdOrderFiles(molist.get(i).getMdNum()));
		}
		
		HashMap<String, ArrayList> map = new HashMap<String, ArrayList>();
		map.put("molist", molist);
		map.put("mdlist", mdlist);
		map.put("flist", flist);
		
		response.setContentType("application/json; charset=UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("shipIng.md")
	public void shipIng(HttpServletResponse response) {
		
		ArrayList<MdOrder> molist = mdService.selectOrderIng(1);
		
		ArrayList<MdProduct> mdlist = new ArrayList<MdProduct>();
		ArrayList<Files> flist = new ArrayList<Files>();
	
		for(int i=0; i<molist.size(); i++) {
			mdlist.addAll(mdService.selectMdOrderProduct(molist.get(i).getMdNum()));
			flist.addAll(mdService.selectMdOrderFiles(molist.get(i).getMdNum()));
		}
		
		HashMap<String, ArrayList> map = new HashMap<String, ArrayList>();
		map.put("molist", molist);
		map.put("mdlist", mdlist);
		map.put("flist", flist);
		
		response.setContentType("application/json; charset=UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	
	
	@RequestMapping("shipEndManager.md")
	public void shipEnd(HttpServletResponse response) {
		ArrayList<MdOrder> molist = mdService.selectOrderIng(2);
		
		ArrayList<MdProduct> mdlist = new ArrayList<MdProduct>();
		ArrayList<Files> flist = new ArrayList<Files>();
	
		for(int i=0; i<molist.size(); i++) {
			mdlist.addAll(mdService.selectMdOrderProduct(molist.get(i).getMdNum()));
			flist.addAll(mdService.selectMdOrderFiles(molist.get(i).getMdNum()));
		}
		
		HashMap<String, ArrayList> map = new HashMap<String, ArrayList>();
		map.put("molist", molist);
		map.put("mdlist", mdlist);
		map.put("flist", flist);
		
		response.setContentType("application/json; charset=UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}				
	}
	
	
	
}
