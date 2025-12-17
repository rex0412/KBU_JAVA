package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import dao.ProductDAO;
import dto.ProductDTO;

@WebServlet("/productUpdate")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProductUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            out.println("<script>alert('권한이 없습니다.'); location.href='login.jsp';</script>");
            return;
        }

        try {
            // [핵심] 파일 처리
            Part filePart = request.getPart("thumbnail");
            byte[] imageData = null;
            if (filePart != null && filePart.getSize() > 0) {
                InputStream is = filePart.getInputStream();
                imageData = is.readAllBytes();
            }

            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String color = request.getParameter("color");
            int price = Integer.parseInt(request.getParameter("price"));
            
            int salePrice = 0;
            String salePriceStr = request.getParameter("sale_price");
            if(salePriceStr != null && !salePriceStr.trim().isEmpty()) salePrice = Integer.parseInt(salePriceStr);
            
            int stock = Integer.parseInt(request.getParameter("stock"));
            String status = request.getParameter("status");
            String description = request.getParameter("description");
            String isNew = request.getParameter("is_new") != null ? "Y" : "N";

            ProductDTO product = new ProductDTO();
            product.setProductId(productId);
            product.setName(name);
            product.setCategory(category);
            product.setColor(color);
            product.setPrice(price);
            product.setSalePrice(salePrice);
            product.setStock(stock);
            product.setStatus(status);
            product.setDescription(description);
            product.setIsNew(isNew);
            product.setImageData(imageData); // 새 이미지 있으면 설정, 없으면 null

            ProductDAO dao = new ProductDAO();
            int result = dao.updateProduct(product);

            if (result > 0) {
                out.println("<script>alert('상품 정보가 수정되었습니다.'); location.href='productList.jsp';</script>");
            } else {
                out.println("<script>alert('상품 수정 실패.'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류: " + e.getMessage().replace("'", "\\'") + "'); history.back();</script>");
        }
    }
}