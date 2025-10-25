/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "Promotions")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Promotions.findAll", query = "SELECT p FROM Promotions p"),
    @NamedQuery(name = "Promotions.findById", query = "SELECT p FROM Promotions p WHERE p.id = :id"),
    @NamedQuery(name = "Promotions.findByCode", query = "SELECT p FROM Promotions p WHERE p.code = :code"),
    @NamedQuery(name = "Promotions.findByDiscountPercentage", query = "SELECT p FROM Promotions p WHERE p.discountPercentage = :discountPercentage"),
    @NamedQuery(name = "Promotions.findByMaxDiscount", query = "SELECT p FROM Promotions p WHERE p.maxDiscount = :maxDiscount"),
    @NamedQuery(name = "Promotions.findByValidFrom", query = "SELECT p FROM Promotions p WHERE p.validFrom = :validFrom"),
    @NamedQuery(name = "Promotions.findByValidTo", query = "SELECT p FROM Promotions p WHERE p.validTo = :validTo"),
    @NamedQuery(name = "Promotions.findByApplicableModels", query = "SELECT p FROM Promotions p WHERE p.applicableModels = :applicableModels"),
    @NamedQuery(name = "Promotions.findByMinRentalDays", query = "SELECT p FROM Promotions p WHERE p.minRentalDays = :minRentalDays")})
public class Promotions implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Size(max = 50)
    @Column(name = "Code")
    private String code;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "DiscountPercentage")
    private BigDecimal discountPercentage;
    @Column(name = "MaxDiscount")
    private BigDecimal maxDiscount;
    @Column(name = "ValidFrom")
    @Temporal(TemporalType.DATE)
    private Date validFrom;
    @Column(name = "ValidTo")
    @Temporal(TemporalType.DATE)
    private Date validTo;
    @Size(max = 500)
    @Column(name = "ApplicableModels")
    private String applicableModels;
    @Column(name = "MinRentalDays")
    private Integer minRentalDays;

    public Promotions() {
    }

    public Promotions(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public BigDecimal getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(BigDecimal discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public BigDecimal getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(BigDecimal maxDiscount) {
        this.maxDiscount = maxDiscount;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }

    public String getApplicableModels() {
        return applicableModels;
    }

    public void setApplicableModels(String applicableModels) {
        this.applicableModels = applicableModels;
    }

    public Integer getMinRentalDays() {
        return minRentalDays;
    }

    public void setMinRentalDays(Integer minRentalDays) {
        this.minRentalDays = minRentalDays;
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
        if (!(object instanceof Promotions)) {
            return false;
        }
        Promotions other = (Promotions) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Promotions[ id=" + id + " ]";
    }
    
}
