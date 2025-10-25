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
@Table(name = "Cancellations")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cancellations.findAll", query = "SELECT c FROM Cancellations c"),
    @NamedQuery(name = "Cancellations.findById", query = "SELECT c FROM Cancellations c WHERE c.id = :id"),
    @NamedQuery(name = "Cancellations.findByCancellationDate", query = "SELECT c FROM Cancellations c WHERE c.cancellationDate = :cancellationDate"),
    @NamedQuery(name = "Cancellations.findByRefundAmount", query = "SELECT c FROM Cancellations c WHERE c.refundAmount = :refundAmount"),
    @NamedQuery(name = "Cancellations.findByPenaltyAmount", query = "SELECT c FROM Cancellations c WHERE c.penaltyAmount = :penaltyAmount"),
    @NamedQuery(name = "Cancellations.findByReason", query = "SELECT c FROM Cancellations c WHERE c.reason = :reason"),
    @NamedQuery(name = "Cancellations.findByCreatedAt", query = "SELECT c FROM Cancellations c WHERE c.createdAt = :createdAt")})
public class Cancellations implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Column(name = "CancellationDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date cancellationDate;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "RefundAmount")
    private BigDecimal refundAmount;
    @Column(name = "PenaltyAmount")
    private BigDecimal penaltyAmount;
    @Size(max = 2147483647)
    @Column(name = "Reason")
    private String reason;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "BookingId", referencedColumnName = "Id")
    @ManyToOne
    private Bookings bookingId;

    public Cancellations() {
    }

    public Cancellations(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getCancellationDate() {
        return cancellationDate;
    }

    public void setCancellationDate(Date cancellationDate) {
        this.cancellationDate = cancellationDate;
    }

    public BigDecimal getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(BigDecimal refundAmount) {
        this.refundAmount = refundAmount;
    }

    public BigDecimal getPenaltyAmount() {
        return penaltyAmount;
    }

    public void setPenaltyAmount(BigDecimal penaltyAmount) {
        this.penaltyAmount = penaltyAmount;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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
        if (!(object instanceof Cancellations)) {
            return false;
        }
        Cancellations other = (Cancellations) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Cancellations[ id=" + id + " ]";
    }
    
}
