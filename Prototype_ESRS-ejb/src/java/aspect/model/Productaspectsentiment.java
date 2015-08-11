/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.json.JsonObject;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Entity
@Table(name = "productaspectsentiment")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productaspectsentiment.findAll", query = "SELECT p FROM Productaspectsentiment p"),
    @NamedQuery(name = "Productaspectsentiment.findByProdid", query = "SELECT p FROM Productaspectsentiment p WHERE p.productaspectsentimentPK.prodid = :prodid"),
    @NamedQuery(name = "Productaspectsentiment.findByAspect", query = "SELECT p FROM Productaspectsentiment p WHERE p.productaspectsentimentPK.aspect = :aspect"),
    @NamedQuery(name = "Productaspectsentiment.findByScore", query = "SELECT p FROM Productaspectsentiment p WHERE p.score = :score"),
    @NamedQuery(name = "Productaspectsentiment.findByFreq", query = "SELECT p FROM Productaspectsentiment p WHERE p.freq = :freq"),
    @NamedQuery(name = "Productaspectsentiment.findByGini", query = "SELECT p FROM Productaspectsentiment p WHERE p.gini = :gini")})
public class Productaspectsentiment implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProductaspectsentimentPK productaspectsentimentPK;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "score")
    private BigDecimal score;
    @Column(name = "freq")
    private Integer freq;
    @Column(name = "gini")
    private BigDecimal gini;

    public Productaspectsentiment() {
    }

    public Productaspectsentiment(ProductaspectsentimentPK productaspectsentimentPK) {
        this.productaspectsentimentPK = productaspectsentimentPK;
    }

    public Productaspectsentiment(String prodid, String aspect) {
        this.productaspectsentimentPK = new ProductaspectsentimentPK(prodid, aspect);
    }

    public ProductaspectsentimentPK getProductaspectsentimentPK() {
        return productaspectsentimentPK;
    }

    public void setProductaspectsentimentPK(ProductaspectsentimentPK productaspectsentimentPK) {
        this.productaspectsentimentPK = productaspectsentimentPK;
    }

    public BigDecimal getScore() {
        return score;
    }

    public void setScore(BigDecimal score) {
        this.score = score;
    }

    public Integer getFreq() {
        return freq;
    }

    public void setFreq(Integer freq) {
        this.freq = freq;
    }

    public BigDecimal getGini() {
        return gini;
    }

    public void setGini(BigDecimal gini) {
        this.gini = gini;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productaspectsentimentPK != null ? productaspectsentimentPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productaspectsentiment)) {
            return false;
        }
        Productaspectsentiment other = (Productaspectsentiment) object;
        if ((this.productaspectsentimentPK == null && other.productaspectsentimentPK != null) || (this.productaspectsentimentPK != null && !this.productaspectsentimentPK.equals(other.productaspectsentimentPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Productaspectsentiment[ productaspectsentimentPK=" + productaspectsentimentPK + " ]";
    }
    
    public JSONObject toJason() throws JSONException{
    JSONObject json = new JSONObject();
    json.put("score", score);
    json.put("freq", freq);
    json.put("gini", gini);
    return json;
    }
    
}
