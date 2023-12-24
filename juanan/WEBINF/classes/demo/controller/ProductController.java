package juanan.WEBINF.classes.demo.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;

import juanan.WEBINF.classes.demo.app.ProductHelper;
import juanan.WEBINF.classes.tools.JsonReader;
import javax.servlet.annotation.WebServlet;

@WebServlet("/api/product.do")
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductHelper ph = ProductHelper.getHelper();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        String action = jsr.getParameter("action");

        JSONObject resp = new JSONObject();
        if ("getAll".equals(action)) {
            resp = ph.getAllProducts();
        } else if ("getInfo".equals(action)) {
            String productName = jsr.getParameter("product_name");
            resp = ph.getProductInfo(productName);
        } else if ("viewTotalQuantity".equals(action)) { // 新增的处理逻辑
            String productName = jsr.getParameter("product_name");
            resp = ph.viewTotalProductQuantity(productName);
        }

        jsr.response(resp, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        String action = jso.optString("action");

        JSONObject resp = new JSONObject();
        switch (action) {
            case "add":
                int productId = jso.getInt("product_id");
                String productName = jso.getString("product_name");
                int supplierId = jso.getInt("supplier_id");
                int productLocation = jso.getInt("product_location");
                int productQuantity = jso.getInt("product_quantity");
                int productPrice = jso.getInt("product_price");
                resp = ph.addProduct(productId, productName, supplierId, productLocation, productQuantity,
                        productPrice);
                break;
            case "delete":
                productId = jso.getInt("product_id");
                resp = ph.deleteProduct(productId);
                break;
            case "update":
                productId = jso.getInt("product_id");
                productName = jso.getString("product_name");
                supplierId = jso.getInt("supplier_id");
                productLocation = jso.getInt("warehouse_id");
                productQuantity = jso.getInt("quantity");
                productPrice = jso.getInt("price");
                resp = ph.updateProduct(productId, productName, supplierId, productLocation, productQuantity,
                        productPrice);
                break;
            default:
                resp.put("status", "400");
                resp.put("message", "無效的請求操作");
                break;
        }

        jsr.response(resp, response);
    }
}
