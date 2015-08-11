/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author eneye380
 */
@Entity
@Table(name = "queryproductandrecommendation")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Queryproductandrecommendation.findAll", query = "SELECT q FROM Queryproductandrecommendation q"),
    @NamedQuery(name = "Queryproductandrecommendation.findByQueryProduct", query = "SELECT q FROM Queryproductandrecommendation q WHERE q.queryProduct = :queryProduct"),
    @NamedQuery(name = "Queryproductandrecommendation.findByName", query = "SELECT q FROM Queryproductandrecommendation q WHERE q.name = :name"),
    @NamedQuery(name = "Queryproductandrecommendation.findByRecommProduct1", query = "SELECT q FROM Queryproductandrecommendation q WHERE q.recommProduct1 = :recommProduct1"),
    @NamedQuery(name = "Queryproductandrecommendation.findByRecommProduct2", query = "SELECT q FROM Queryproductandrecommendation q WHERE q.recommProduct2 = :recommProduct2"),
    @NamedQuery(name = "Queryproductandrecommendation.findByRecommProduct3", query = "SELECT q FROM Queryproductandrecommendation q WHERE q.recommProduct3 = :recommProduct3")})
public class Queryproductandrecommendation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "queryProduct")
    private String queryProduct;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 64)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "recommProduct1")
    private String recommProduct1;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "recommProduct2")
    private String recommProduct2;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 11)
    @Column(name = "recommProduct3")
    private String recommProduct3;

    public Queryproductandrecommendation() {
    }

    public Queryproductandrecommendation(String queryProduct) {
        this.queryProduct = queryProduct;
    }

    public Queryproductandrecommendation(String queryProduct, String name, String recommProduct1, String recommProduct2, String recommProduct3) {
        this.queryProduct = queryProduct;
        this.name = name;
        this.recommProduct1 = recommProduct1;
        this.recommProduct2 = recommProduct2;
        this.recommProduct3 = recommProduct3;
    }

    public String getQueryProduct() {
        return queryProduct;
    }

    public void setQueryProduct(String queryProduct) {
        this.queryProduct = queryProduct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRecommProduct1() {
        return recommProduct1;
    }

    public void setRecommProduct1(String recommProduct1) {
        this.recommProduct1 = recommProduct1;
    }

    public String getRecommProduct2() {
        return recommProduct2;
    }

    public void setRecommProduct2(String recommProduct2) {
        this.recommProduct2 = recommProduct2;
    }

    public String getRecommProduct3() {
        return recommProduct3;
    }

    public void setRecommProduct3(String recommProduct3) {
        this.recommProduct3 = recommProduct3;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (queryProduct != null ? queryProduct.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Queryproductandrecommendation)) {
            return false;
        }
        Queryproductandrecommendation other = (Queryproductandrecommendation) object;
        if ((this.queryProduct == null && other.queryProduct != null) || (this.queryProduct != null && !this.queryProduct.equals(other.queryProduct))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Queryproductandrecommendation[ queryProduct=" + queryProduct + " ]";
    }
    
}
