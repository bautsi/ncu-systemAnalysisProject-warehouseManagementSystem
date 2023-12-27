package ncu.im3069.demo.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.*;
import ncu.im3069.demo.app.SupplierHelper;
import ncu.im3069.tools.JsonReader;
import javax.servlet.annotation.WebServlet;

@WebServlet("/api/supplier.do")
public class SupplierController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SupplierHelper sh = SupplierHelper.getHelper();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        String action = jsr.getParameter("action");

        JSONObject resp = new JSONObject();
        if ("getAll".equals(action)) {
            resp = sh.getAllSuppliers();
        } else {
            // 其他 GET 請求的處理
        }

        jsr.response(resp, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JsonReader jsr = new JsonReader(request);
        JSONObject jso = jsr.getObject();
        String action = jso.optString("action");

        JSONObject resp = new JSONObject();
        switch (action) {
            case "add":
                String supplierName = jso.getString("supplier_name");
                resp = sh.addSupplier(supplierName);
                break;
            case "delete":
                int supplierId = jso.getInt("supplier_id");
                resp = sh.deleteSupplier(supplierId);
                break;
            case "update":
                supplierId = jso.getInt("supplier_id");
                supplierName = jso.getString("supplier_name");
                resp = sh.updateSupplier(supplierId, supplierName);
                break;
            default:
                resp.put("status", "400");
                resp.put("message", "無效的請求操作");
                break;
        }

        jsr.response(resp, response);
    }
}
