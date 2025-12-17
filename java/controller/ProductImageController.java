package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import dao.ProductDAO;
import dto.ProductDTO;

@WebServlet("/productImage")
public class ProductImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) return;

        try {
            int productId = Integer.parseInt(idStr);
            ProductDAO dao = new ProductDAO();
            ProductDTO product = dao.getProductById(productId);
    
            if (product != null && product.getImageData() != null) {
                response.setContentType("image/jpeg"); // 또는 image/png
                response.setContentLength(product.getImageData().length);
                
                OutputStream out = response.getOutputStream();
                out.write(product.getImageData());
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}