<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dto.OrderDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="dto.CartDTO" %>
<%@ page import="dao.ProductDAO" %> <%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    
    String receiverName = request.getParameter("receiverName");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String memo = request.getParameter("memo");
    String type = request.getParameter("type"); 
    String summary = request.getParameter("productName");
    
    int totalPrice = 0;
    try { totalPrice = Integer.parseInt(request.getParameter("totalPrice")); } catch(Exception e) {}

    UserDAO uDao = new UserDAO();
    int userPK = uDao.getUserPK(userID);

    // 대표 상품 ID 구하기
    int repProductId = 0;
    if("direct".equals(type)) {
        try { repProductId = Integer.parseInt(request.getParameter("productId")); } catch(Exception e){}
    } else {
        // 장바구니의 첫 번째 상품 ID 가져오기
        CartDAO cDao = new CartDAO();
        ArrayList<CartDTO> cList = cDao.getCartList(userPK);
        if(cList.size() > 0) repProductId = cList.get(0).getProductId();
    }

    OrderDTO order = new OrderDTO();
    order.setUserId(userPK);
    order.setReceiverName(receiverName);
    order.setReceiverPhone(phone);
    order.setAddress(address);
    order.setRequestMemo(memo);
    order.setTotalPrice(totalPrice);
    order.setSummary(summary);
    order.setProductId(repProductId); 

    OrderDAO orderDao = new OrderDAO();
    int result = orderDao.insertOrder(order);
    
    if (result > 0) {
        // [수정2] 재고 차감 로직 정리 (변수 선언 위치 및 로직 순서 교정)
        ProductDAO pDao = new ProductDAO(); 
        
        // 1. 바로 구매(direct)일 경우
        if ("direct".equals(type)) {
            int qty = Integer.parseInt(request.getParameter("quantity"));
            int pId = Integer.parseInt(request.getParameter("productId"));
            pDao.decreaseStock(pId, qty); // 재고 차감
        } 
        // 2. 장바구니 구매(cart)일 경우
        else {
            CartDAO cDao = new CartDAO();
            
            // [중요] 장바구니를 비우기 *전에* 목록을 가져와서 재고를 차감해야 함
            ArrayList<CartDTO> cList = cDao.getCartList(userPK);
            
            for(CartDTO c : cList) {
                pDao.decreaseStock(c.getProductId(), c.getQuantity()); // 재고 차감
            }
            
            // 재고 차감 후 장바구니 비우기
            cDao.clearCart(userPK); 
        }

        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('주문이 성공적으로 완료되었습니다.');");
        script.println("location.href = 'orderList.jsp';");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('주문 처리에 실패했습니다.'); history.back();</script>");
    }
%>