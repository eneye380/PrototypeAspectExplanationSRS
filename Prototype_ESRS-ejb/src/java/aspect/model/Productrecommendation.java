/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author eneye380
 */
@Entity
@Table(name = "productrecommendation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productrecommendation.findAll", query = "SELECT p FROM Productrecommendation p"),
    @NamedQuery(name = "Productrecommendation.findByQueryproduct", query = "SELECT p FROM Productrecommendation p WHERE p.productrecommendationPK.queryproduct = :queryproduct"),
    @NamedQuery(name = "Productrecommendation.findByRecommendation", query = "SELECT p FROM Productrecommendation p WHERE p.productrecommendationPK.recommendation = :recommendation")})
public class Productrecommendation implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProductrecommendationPK productrecommendationPK;

    public Productrecommendation() {
    }

    public Productrecommendation(ProductrecommendationPK productrecommendationPK) {
        this.productrecommendationPK = productrecommendationPK;
    }

    public Productrecommendation(String queryproduct, String recommendation) {
        this.productrecommendationPK = new ProductrecommendationPK(queryproduct, recommendation);
    }

    public ProductrecommendationPK getProductrecommendationPK() {
        return productrecommendationPK;
    }

    public void setProductrecommendationPK(ProductrecommendationPK productrecommendationPK) {
        this.productrecommendationPK = productrecommendationPK;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productrecommendationPK != null ? productrecommendationPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productrecommendation)) {
            return false;
        }
        Productrecommendation other = (Productrecommendation) object;
        if ((this.productrecommendationPK == null && other.productrecommendationPK != null) || (this.productrecommendationPK != null && !this.productrecommendationPK.equals(other.productrecommendationPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Productrecommendation[ productrecommendationPK=" + productrecommendationPK + " ]";
    }
    
}
