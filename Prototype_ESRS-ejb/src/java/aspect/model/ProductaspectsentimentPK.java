/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Embeddable
public class ProductaspectsentimentPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "prodid")
    private String prodid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 32)
    @Column(name = "aspect")
    private String aspect;

    public ProductaspectsentimentPK() {
    }

    public ProductaspectsentimentPK(String prodid, String aspect) {
        this.prodid = prodid;
        this.aspect = aspect;
    }

    public String getProdid() {
        return prodid;
    }

    public void setProdid(String prodid) {
        this.prodid = prodid;
    }

    public String getAspect() {
        return aspect;
    }

    public void setAspect(String aspect) {
        this.aspect = aspect;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prodid != null ? prodid.hashCode() : 0);
        hash += (aspect != null ? aspect.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductaspectsentimentPK)) {
            return false;
        }
        ProductaspectsentimentPK other = (ProductaspectsentimentPK) object;
        if ((this.prodid == null && other.prodid != null) || (this.prodid != null && !this.prodid.equals(other.prodid))) {
            return false;
        }
        if ((this.aspect == null && other.aspect != null) || (this.aspect != null && !this.aspect.equals(other.aspect))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.ProductaspectsentimentPK[ prodid=" + prodid + ", aspect=" + aspect + " ]";
    }
    
    public JSONObject toJson(){
        JSONObject json = new JSONObject();
        try {
            json.put("prodid", prodid);
            json.put("aspect", aspect);
            return json;
        } catch (JSONException ex) {
            
        }
        return null;
    }
    
}
