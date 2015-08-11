/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Lob;
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
@Table(name = "productreview")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Productreview.findAll", query = "SELECT p FROM Productreview p"),
    @NamedQuery(name = "Productreview.findByAuthor", query = "SELECT p FROM Productreview p WHERE p.productreviewPK.author = :author"),
    @NamedQuery(name = "Productreview.findByProdid", query = "SELECT p FROM Productreview p WHERE p.productreviewPK.prodid = :prodid"),
    @NamedQuery(name = "Productreview.findByBadges", query = "SELECT p FROM Productreview p WHERE p.badges = :badges"),
    @NamedQuery(name = "Productreview.findByHelpfulranking", query = "SELECT p FROM Productreview p WHERE p.helpfulranking = :helpfulranking"),
    @NamedQuery(name = "Productreview.findByTitle", query = "SELECT p FROM Productreview p WHERE p.title = :title"),
    @NamedQuery(name = "Productreview.findByDate", query = "SELECT p FROM Productreview p WHERE p.date = :date"),
    @NamedQuery(name = "Productreview.findByRating", query = "SELECT p FROM Productreview p WHERE p.rating = :rating"),
    @NamedQuery(name = "Productreview.findByNpeopleuseful", query = "SELECT p FROM Productreview p WHERE p.npeopleuseful = :npeopleuseful"),
    @NamedQuery(name = "Productreview.findByNpeoplevoted", query = "SELECT p FROM Productreview p WHERE p.npeoplevoted = :npeoplevoted"),
    @NamedQuery(name = "Productreview.findByNcomments", query = "SELECT p FROM Productreview p WHERE p.ncomments = :ncomments")})
public class Productreview implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProductreviewPK productreviewPK;
    @Size(max = 32)
    @Column(name = "badges")
    private String badges;
    @Size(max = 10)
    @Column(name = "helpfulranking")
    private String helpfulranking;
    @Size(max = 255)
    @Column(name = "title")
    private String title;
    @Size(max = 12)
    @Column(name = "date")
    private String date;
    @Size(max = 10)
    @Column(name = "rating")
    private String rating;
    @Size(max = 10)
    @Column(name = "npeopleuseful")
    private String npeopleuseful;
    @Size(max = 10)
    @Column(name = "npeoplevoted")
    private String npeoplevoted;
    @Size(max = 10)
    @Column(name = "ncomments")
    private String ncomments;
    @Lob
    @Size(max = 65535)
    @Column(name = "comments")
    private String comments;

    public Productreview() {
    }

    public Productreview(ProductreviewPK productreviewPK) {
        this.productreviewPK = productreviewPK;
    }

    public Productreview(String author, String prodid) {
        this.productreviewPK = new ProductreviewPK(author, prodid);
    }

    public ProductreviewPK getProductreviewPK() {
        return productreviewPK;
    }

    public void setProductreviewPK(ProductreviewPK productreviewPK) {
        this.productreviewPK = productreviewPK;
    }

    public String getBadges() {
        return badges;
    }

    public void setBadges(String badges) {
        this.badges = badges;
    }

    public String getHelpfulranking() {
        return helpfulranking;
    }

    public void setHelpfulranking(String helpfulranking) {
        this.helpfulranking = helpfulranking;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getNpeopleuseful() {
        return npeopleuseful;
    }

    public void setNpeopleuseful(String npeopleuseful) {
        this.npeopleuseful = npeopleuseful;
    }

    public String getNpeoplevoted() {
        return npeoplevoted;
    }

    public void setNpeoplevoted(String npeoplevoted) {
        this.npeoplevoted = npeoplevoted;
    }

    public String getNcomments() {
        return ncomments;
    }

    public void setNcomments(String ncomments) {
        this.ncomments = ncomments;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productreviewPK != null ? productreviewPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productreview)) {
            return false;
        }
        Productreview other = (Productreview) object;
        if ((this.productreviewPK == null && other.productreviewPK != null) || (this.productreviewPK != null && !this.productreviewPK.equals(other.productreviewPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "aspect.model.Productreview[ productreviewPK=" + productreviewPK + " ]";
    }
    
}
