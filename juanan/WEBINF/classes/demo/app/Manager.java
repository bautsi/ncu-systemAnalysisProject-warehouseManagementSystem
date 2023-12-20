package juanan.WEBINF.classes.demo.app;

import java.sql.*;
import java.util.*;

import org.json.*;

// TODO: Auto-generated Javadoc
/**
 * <p>
 * The Class Manager
 * Manager類別（class）具有管理員所需要之屬性與方法，並且儲存與管理員相關之商業判斷邏輯<br>
 * </p>
 * 
 * @author IPLab
 * @version 1.0.0
 * @since 1.0.0
 */

public class Manager {
    
    /** id，管理員編號 */
    private int id;

    /** name，管理員姓名 */
    private String name;
    
    /** email，管理員電子郵件信箱 */
    private String email;
    
    /** password，管理員密碼 */
    private String password;

    /** list，管理員列表 */
    private ArrayList<Manager> list = new ArrayList<Manager>();
    
    /** mh，ManagerHelper之物件與Manager相關之資料庫方法（Sigleton） */
    private ManagerHelper mh =  ManagerHelper.getHelper();
    
    /**
     * 實例化（Instantiates）一個新的（new）Manager物件<br>
     * 採用多載（overload）方法進行，此建構子用於建立管理員資料時，產生一名新的管理員
     *
     * @param name 管理員姓名
     * @param email 管理員電子信箱
     * @param password 管理員密碼
     */
    public Manager(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    /**
     * 實例化（Instantiates）一個新的（new）Manager物件<br>
     * 採用多載（overload）方法進行，此建構子用於更新管理員資料時，產生一名管理員
     * 
     * @param id 管理員編號
     * @param name 管理員姓名
     * @param email 管理員電子信箱
     * @param password 管理員密碼
     */
    public Manager(int id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    /**
     * 設定管理員之編號
     */
    public void setID(int id) {
        this.id = id;
    }
    
    /**
     * 取得管理員之編號
     *
     * @return the id 回傳管理員編號
     */
    public int getID() {
        return this.id;
    }

    /**
     * 取得管理員之姓名
     *
     * @return the name 回傳管理員姓名
     */
    public String getName() {
        return this.name;
    }

    /**
     * 取得管理員之電子郵件信箱
     *
     * @return the email 回傳管理員電子郵件信箱
     */
    public String getEmail() {
        return this.email;
    }
    
    /**
     * 取得管理員之密碼
     *
     * @return the password 回傳管理員密碼
     */
    public String getPassword() {
        return this.password;
    }
    
    /**
     * 更新管理員資料
     *
     * @return the JSON object 回傳SQL更新之結果與相關封裝之資料
     */
    public JSONObject update() {
        /** 新建一個JSONObject用以儲存更新後之資料 */
        JSONObject data = new JSONObject();
        
        /** 檢查該名管理員是否已經在資料庫 */
        if(this.id != 0) {
            /** 透過ManagerHelper物件，更新目前之管理員資料置資料庫中 */
            data = mh.update(this);
        }
        
        return data;
    }
    
    /**
     * 取得該名管理員所有資料
     *
     * @return the data 取得該名管理員之所有資料並封裝於JSONObject物件內
     */
    public JSONObject getData() {
        /** 透過JSONObject將該名管理員所需之資料全部進行封裝*/ 
        JSONObject jso = new JSONObject();
        jso.put("id", getID());
        jso.put("name", getName());
        jso.put("email", getEmail());
        jso.put("password", getPassword());
        
        return jso;
    }
}