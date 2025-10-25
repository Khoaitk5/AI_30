/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
@Table(name = "AdditionalFees")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AdditionalFees.findAll", query = "SELECT a FROM AdditionalFees a"),
    @NamedQuery(name = "AdditionalFees.findById", query = "SELECT a FROM AdditionalFees a WHERE a.id = :id"),
    @NamedQuery(name = "AdditionalFees.findByFeeType", query = "SELECT a FROM AdditionalFees a WHERE a.feeType = :feeType"),
    @NamedQuery(name = "AdditionalFees.findByAmount", query = "SELECT a FROM AdditionalFees a WHERE a.amount = :amount"),
    @NamedQuery(name = "AdditionalFees.findByDescription", query = "SELECT a FROM AdditionalFees a WHERE a.description = :description"),
    @NamedQuery(name = "AdditionalFees.findByCreatedAt", query = "SELECT a FROM AdditionalFees a WHERE a.createdAt = :createdAt")})
public class AdditionalFees implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Size(max = 50)
    @Column(name = "FeeType")
    private String feeType;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "Amount")
    private BigDecimal amount;
    @Size(max = 2147483647)
    @Column(name = "Description")
    private String description;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "BookingId", referencedColumnName = "Id")
    @ManyToOne
    private Bookings bookingId;

    public AdditionalFees() {
    }

    public AdditionalFees(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Bookings getBookingId() {
        return bookingId;
    }

    public void setBookingId(Bookings bookingId) {
        this.bookingId = bookingId;
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
        if (!(object instanceof AdditionalFees)) {
            return false;
        }
        AdditionalFees other = (AdditionalFees) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.AdditionalFees[ id=" + id + " ]";
    }
    
}
