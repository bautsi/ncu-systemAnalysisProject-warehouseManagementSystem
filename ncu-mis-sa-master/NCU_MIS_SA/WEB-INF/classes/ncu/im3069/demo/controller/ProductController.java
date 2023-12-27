package ncu.im3069.demo.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;

import ncu.im3069.demo.app.ProductHelper;
import ncu.im3069.tools.JsonReader;
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
        } else {
            // 其他 GET 请求的处理逻辑
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
            String productName = jso.getString("product_name");
            int supplierId = jso.getInt("supplier_id");
            int warehouseId = jso.getInt("warehouse_id");
            int productQuantity = jso.getInt("product_quantity");
            int productPrice = jso.getInt("product_price");
            resp = ph.addProduct(productName, supplierId, warehouseId, productQuantity, productPrice);
            break;
        case "delete":
            int productId = jso.getInt("product_id");
            resp = ph.deleteProduct(productId);
            break;
        case "update":
            productId = jso.getInt("product_id");
            productName = jso.getString("product_name");
            supplierId = jso.getInt("supplier_id");
            String productLocation = jso.getString("product_location");
            productQuantity = jso.getInt("product_quantity");
            productPrice = jso.getInt("product_price");
            resp = ph.updateProduct(productId, productName, supplierId, productLocation, productQuantity,
                    productPrice);
            break;
            default:
                resp.put("status", "400");
                resp.put("message", "Invalid request operation");
                break;
        }

        jsr.response(resp, response);
    }
}
