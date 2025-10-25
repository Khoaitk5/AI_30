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
@Table(name = "DamageReports")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DamageReports.findAll", query = "SELECT d FROM DamageReports d"),
    @NamedQuery(name = "DamageReports.findById", query = "SELECT d FROM DamageReports d WHERE d.id = :id"),
    @NamedQuery(name = "DamageReports.findByReportedDate", query = "SELECT d FROM DamageReports d WHERE d.reportedDate = :reportedDate"),
    @NamedQuery(name = "DamageReports.findByDescription", query = "SELECT d FROM DamageReports d WHERE d.description = :description"),
    @NamedQuery(name = "DamageReports.findByRepairCost", query = "SELECT d FROM DamageReports d WHERE d.repairCost = :repairCost"),
    @NamedQuery(name = "DamageReports.findByStatus", query = "SELECT d FROM DamageReports d WHERE d.status = :status"),
    @NamedQuery(name = "DamageReports.findByCustomerResponsible", query = "SELECT d FROM DamageReports d WHERE d.customerResponsible = :customerResponsible"),
    @NamedQuery(name = "DamageReports.findByCreatedAt", query = "SELECT d FROM DamageReports d WHERE d.createdAt = :createdAt")})
public class DamageReports implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Column(name = "ReportedDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date reportedDate;
    @Size(max = 2147483647)
    @Column(name = "Description")
    private String description;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "RepairCost")
    private BigDecimal repairCost;
    @Size(max = 50)
    @Column(name = "Status")
    private String status;
    @Column(name = "CustomerResponsible")
    private Boolean customerResponsible;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @JoinColumn(name = "BookingId", referencedColumnName = "Id")
    @ManyToOne
    private Bookings bookingId;
    @JoinColumn(name = "CarId", referencedColumnName = "Id")
    @ManyToOne
    private Cars carId;

    public DamageReports() {
    }

    public DamageReports(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getReportedDate() {
        return reportedDate;
    }

    public void setReportedDate(Date reportedDate) {
        this.reportedDate = reportedDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getRepairCost() {
        return repairCost;
    }

    public void setRepairCost(BigDecimal repairCost) {
        this.repairCost = repairCost;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Boolean getCustomerResponsible() {
        return customerResponsible;
    }

    public void setCustomerResponsible(Boolean customerResponsible) {
        this.customerResponsible = customerResponsible;
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

    public Cars getCarId() {
        return carId;
    }

    public void setCarId(Cars carId) {
        this.carId = carId;
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
        if (!(object instanceof DamageReports)) {
            return false;
        }
        DamageReports other = (DamageReports) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.DamageReports[ id=" + id + " ]";
    }
    
}
