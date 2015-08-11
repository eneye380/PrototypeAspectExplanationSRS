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
@Table(name = "productdetail")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productdetail.findAll", query = "SELECT p FROM Productdetail p"),
    @NamedQuery(name = "Productdetail.findByProdid", query = "SELECT p FROM Productdetail p WHERE p.prodid = :prodid"),
    @NamedQuery(name = "Productdetail.findByName", query = "SELECT p FROM Productdetail p WHERE p.name = :name"),
    @NamedQuery(name = "Productdetail.findByDate", query = "SELECT p FROM Productdetail p WHERE p.date = :date"),
    @NamedQuery(name = "Productdetail.findByRank", query = "SELECT p FROM Productdetail p WHERE p.rank = :rank"),
    @NamedQuery(name = "Productdetail.findByPrice", query = "SELECT p FROM Productdetail p WHERE p.price = :price"),
    @NamedQuery(name = "Productdetail.findByCategory", query = "SELECT p FROM Productdetail p WHERE p.category = :category"),
    @NamedQuery(name = "Productdetail.findByRating", query = "SELECT p FROM Productdetail p WHERE p.rating = :rating"),
    @NamedQuery(name = "Productdetail.findByNreviews", query = "SELECT p FROM Productdetail p WHERE p.nreviews = :nreviews"),
    @NamedQuery(name = "Productdetail.findByNcomments", query = "SELECT p FROM Productdetail p WHERE p.ncomments = :ncomments"),
    @NamedQuery(name = "Productdetail.findByNquestions", query = "SELECT p FROM Productdetail p WHERE p.nquestions = :nquestions"),
    @NamedQuery(name = "Productdetail.findByUrl", query = "SELECT p FROM Productdetail p WHERE p.url = :url")})
public class Productdetail implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "prodid")
    private String prodid;
    @Size(max = 128)
    @Column(name = "name")
    private String name;
    @Size(max = 12)
    @Column(name = "date")
    private String date;
    @Size(max = 10)
    @Column(name = "rank")
    private String rank;
    @Size(max = 10)
    @Column(name = "price")
    private String price;
    @Size(max = 32)
    @Column(name = "category")
    private String category;
    @Size(max = 10)
    @Column(name = "rating")
    private String rating;
    @Size(max = 10)
    @Column(name = "nreviews")
    private String nreviews;
    @Size(max = 10)
    @Column(name = "ncomments")
    private String ncomments;
    @Size(max = 10)
    @Column(name = "nquestions")
    private String nquestions;
    @Size(max = 256)
    @Column(name = "url")
    private String url;

    public Productdetail() {
    }

    public Productdetail(String prodid) {
        this.prodid = prodid;
    }

    public String getProdid() {
        return prodid;
    }

    public void setProdid(String prodid) {
        this.prodid = prodid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getNreviews() {
        return nreviews;
    }

    public void setNreviews(String nreviews) {
        this.nreviews = nreviews;
    }

    public String getNcomments() {
        return ncomments;
    }

    public void setNcomments(String ncomments) {
        this.ncomments = ncomments;
    }

    public String getNquestions() {
        return nquestions;
    }

    public void setNquestions(String nquestions) {
        this.nquestions = nquestions;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prodid != null ? prodid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productdetail)) {
            return false;
        }
        Productdetail other = (Productdetail) object;
        if ((this.prodid == null && other.prodid != null) || (this.prodid != null && !this.prodid.equals(other.prodid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Productdetail[ prodid=" + prodid + " ]";
    }
    
}
