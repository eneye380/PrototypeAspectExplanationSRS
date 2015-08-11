/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author eneye380
 */
@Embeddable
public class ProductrecommendationPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "queryproduct")
    private String queryproduct;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "recommendation")
    private String recommendation;

    public ProductrecommendationPK() {
    }

    public ProductrecommendationPK(String queryproduct, String recommendation) {
        this.queryproduct = queryproduct;
        this.recommendation = recommendation;
    }

    public String getQueryproduct() {
        return queryproduct;
    }

    public void setQueryproduct(String queryproduct) {
        this.queryproduct = queryproduct;
    }

    public String getRecommendation() {
        return recommendation;
    }

    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (queryproduct != null ? queryproduct.hashCode() : 0);
        hash += (recommendation != null ? recommendation.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductrecommendationPK)) {
            return false;
        }
        ProductrecommendationPK other = (ProductrecommendationPK) object;
        if ((this.queryproduct == null && other.queryproduct != null) || (this.queryproduct != null && !this.queryproduct.equals(other.queryproduct))) {
            return false;
        }
        if ((this.recommendation == null && other.recommendation != null) || (this.recommendation != null && !this.recommendation.equals(other.recommendation))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.ProductrecommendationPK[ queryproduct=" + queryproduct + ", recommendation=" + recommendation + " ]";
    }
    
}
