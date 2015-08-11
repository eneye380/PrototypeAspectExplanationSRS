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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author eneye380
 */
@Entity
@Table(name = "productboughtafter")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productboughtafter.findAll", query = "SELECT p FROM Productboughtafter p"),
    @NamedQuery(name = "Productboughtafter.findById", query = "SELECT p FROM Productboughtafter p WHERE p.id = :id"),
    @NamedQuery(name = "Productboughtafter.findByProdid", query = "SELECT p FROM Productboughtafter p WHERE p.prodid = :prodid"),
    @NamedQuery(name = "Productboughtafter.findByProductboughtafterurl", query = "SELECT p FROM Productboughtafter p WHERE p.productboughtafterurl = :productboughtafterurl")})
public class Productboughtafter implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Size(max = 12)
    @Column(name = "prodid")
    private String prodid;
    @Size(max = 256)
    @Column(name = "productboughtafterurl")
    private String productboughtafterurl;

    public Productboughtafter() {
    }

    public Productboughtafter(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProdid() {
        return prodid;
    }

    public void setProdid(String prodid) {
        this.prodid = prodid;
    }

    public String getProductboughtafterurl() {
        return productboughtafterurl;
    }

    public void setProductboughtafterurl(String productboughtafterurl) {
        this.productboughtafterurl = productboughtafterurl;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productboughtafter)) {
            return false;
        }
        Productboughtafter other = (Productboughtafter) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Productboughtafter[ id=" + id + " ]";
    }
    
}
