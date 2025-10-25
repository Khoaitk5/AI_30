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
@Table(name = "VehicleReplacements")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VehicleReplacements.findAll", query = "SELECT v FROM VehicleReplacements v"),
    @NamedQuery(name = "VehicleReplacements.findById", query = "SELECT v FROM VehicleReplacements v WHERE v.id = :id"),
    @NamedQuery(name = "VehicleReplacements.findByReason", query = "SELECT v FROM VehicleReplacements v WHERE v.reason = :reason"),
    @NamedQuery(name = "VehicleReplacements.findByReplacementCost", query = "SELECT v FROM VehicleReplacements v WHERE v.replacementCost = :replacementCost"),
    @NamedQuery(name = "VehicleReplacements.findByReplacementDate", query = "SELECT v FROM VehicleReplacements v WHERE v.replacementDate = :replacementDate"),
    @NamedQuery(name = "VehicleReplacements.findByCreatedAt", query = "SELECT v FROM VehicleReplacements v WHERE v.createdAt = :createdAt")})
public class VehicleReplacements implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Size(max = 50)
    @Column(name = "Reason")
    private String reason;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "ReplacementCost")
    private BigDecimal replacementCost;
    @Column(name = "ReplacementDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date replacementDate;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "BookingId", referencedColumnName = "Id")
    @ManyToOne
    private Bookings bookingId;
    @JoinColumn(name = "OriginalCarId", referencedColumnName = "Id")
    @ManyToOne
    private Cars originalCarId;
    @JoinColumn(name = "ReplacementCarId", referencedColumnName = "Id")
    @ManyToOne
    private Cars replacementCarId;

    public VehicleReplacements() {
    }

    public VehicleReplacements(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public BigDecimal getReplacementCost() {
        return replacementCost;
    }

    public void setReplacementCost(BigDecimal replacementCost) {
        this.replacementCost = replacementCost;
    }

    public Date getReplacementDate() {
        return replacementDate;
    }

    public void setReplacementDate(Date replacementDate) {
        this.replacementDate = replacementDate;
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

    public Cars getOriginalCarId() {
        return originalCarId;
    }

    public void setOriginalCarId(Cars originalCarId) {
        this.originalCarId = originalCarId;
    }

    public Cars getReplacementCarId() {
        return replacementCarId;
    }

    public void setReplacementCarId(Cars replacementCarId) {
        this.replacementCarId = replacementCarId;
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
        if (!(object instanceof VehicleReplacements)) {
            return false;
        }
        VehicleReplacements other = (VehicleReplacements) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.VehicleReplacements[ id=" + id + " ]";
    }
    
}
