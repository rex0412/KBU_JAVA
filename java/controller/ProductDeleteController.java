package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import dao.ProductDAO;

@WebServlet("/productDelete")
public class ProductDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		String userRole = (String) session.getAttribute("userRole");
		if (userRole == null || !"ADMIN".equals(userRole)) {
			out.println("<script>alert('권한이 없습니다.'); location.href='login.jsp';</script>");
			return;
		}

		String productIdStr = request.getParameter("productId");
		if (productIdStr == null || productIdStr.isEmpty()) {
			out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
			return;
		}

		int productId = Integer.parseInt(productIdStr);

		ProductDAO dao = new ProductDAO();
		int result = dao.deleteProduct(productId);

		if (result > 0) {
			out.println("<script>alert('상품이 삭제되었습니다.'); location.href='productList.jsp';</script>");
		} else {
			out.println("<script>alert('상품 삭제에 실패했습니다.'); history.back();</script>");
		}
	}
}