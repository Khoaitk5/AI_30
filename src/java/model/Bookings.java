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
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "Bookings")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Bookings.findAll", query = "SELECT b FROM Bookings b"),
    @NamedQuery(name = "Bookings.findById", query = "SELECT b FROM Bookings b WHERE b.id = :id"),
    @NamedQuery(name = "Bookings.findByStartDate", query = "SELECT b FROM Bookings b WHERE b.startDate = :startDate"),
    @NamedQuery(name = "Bookings.findByEndDate", query = "SELECT b FROM Bookings b WHERE b.endDate = :endDate"),
    @NamedQuery(name = "Bookings.findByTotalDays", query = "SELECT b FROM Bookings b WHERE b.totalDays = :totalDays"),
    @NamedQuery(name = "Bookings.findByPricePerDay", query = "SELECT b FROM Bookings b WHERE b.pricePerDay = :pricePerDay"),
    @NamedQuery(name = "Bookings.findByTotalAmount", query = "SELECT b FROM Bookings b WHERE b.totalAmount = :totalAmount"),
    @NamedQuery(name = "Bookings.findByDeposit", query = "SELECT b FROM Bookings b WHERE b.deposit = :deposit"),
    @NamedQuery(name = "Bookings.findByStatus", query = "SELECT b FROM Bookings b WHERE b.status = :status"),
    @NamedQuery(name = "Bookings.findByPickupLocation", query = "SELECT b FROM Bookings b WHERE b.pickupLocation = :pickupLocation"),
    @NamedQuery(name = "Bookings.findByDropoffLocation", query = "SELECT b FROM Bookings b WHERE b.dropoffLocation = :dropoffLocation"),
    @NamedQuery(name = "Bookings.findByNotes", query = "SELECT b FROM Bookings b WHERE b.notes = :notes"),
    @NamedQuery(name = "Bookings.findByDeliveryTime", query = "SELECT b FROM Bookings b WHERE b.deliveryTime = :deliveryTime"),
    @NamedQuery(name = "Bookings.findByReturnTime", query = "SELECT b FROM Bookings b WHERE b.returnTime = :returnTime"),
    @NamedQuery(name = "Bookings.findByCreatedAt", query = "SELECT b FROM Bookings b WHERE b.createdAt = :createdAt"),
    @NamedQuery(name = "Bookings.findByUpdatedAt", query = "SELECT b FROM Bookings b WHERE b.updatedAt = :updatedAt"),
    @NamedQuery(name = "Bookings.findByBillingCycle", query = "SELECT b FROM Bookings b WHERE b.billingCycle = :billingCycle"),
    @NamedQuery(name = "Bookings.findByServiceFeeSummarySentAt", query = "SELECT b FROM Bookings b WHERE b.serviceFeeSummarySentAt = :serviceFeeSummarySentAt")})
public class Bookings implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Column(name = "StartDate")
    @Temporal(TemporalType.DATE)
    private Date startDate;
    @Column(name = "EndDate")
    @Temporal(TemporalType.DATE)
    private Date endDate;
    @Column(name = "TotalDays")
    private Integer totalDays;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "PricePerDay")
    private BigDecimal pricePerDay;
    @Column(name = "TotalAmount")
    private BigDecimal totalAmount;
    @Column(name = "Deposit")
    private BigDecimal deposit;
    @Size(max = 50)
    @Column(name = "Status")
    private String status;
    @Size(max = 200)
    @Column(name = "PickupLocation")
    private String pickupLocation;
    @Size(max = 200)
    @Column(name = "DropoffLocation")
    private String dropoffLocation;
    @Size(max = 2147483647)
    @Column(name = "Notes")
    private String notes;
    @Column(name = "DeliveryTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deliveryTime;
    @Column(name = "ReturnTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date returnTime;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    @Size(max = 50)
    @Column(name = "BillingCycle")
    private String billingCycle;
    @Column(name = "ServiceFeeSummarySentAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date serviceFeeSummarySentAt;
    @OneToMany(mappedBy = "bookingId")
    private Collection<AdditionalFees> additionalFeesCollection;
    @OneToMany(mappedBy = "bookingId")
    private Collection<Payments> paymentsCollection;
    @OneToMany(mappedBy = "bookingId")
    private Collection<Invoices> invoicesCollection;
    @OneToMany(mappedBy = "bookingId")
    private Collection<VehicleReplacements> vehicleReplacementsCollection;
    @OneToMany(mappedBy = "bookingId")
    private Collection<Cancellations> cancellationsCollection;
    @OneToMany(mappedBy = "bookingId")
    private Collection<DamageReports> damageReportsCollection;
    @JoinColumn(name = "CarId", referencedColumnName = "Id")
    @ManyToOne
    private Cars carId;
    @JoinColumn(name = "CustomerId", referencedColumnName = "Id")
    @ManyToOne
    private Customers customerId;

    public Bookings() {
    }

    public Bookings(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(Integer totalDays) {
        this.totalDays = totalDays;
    }

    public BigDecimal getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(BigDecimal pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDeposit() {
        return deposit;
    }

    public void setDeposit(BigDecimal deposit) {
        this.deposit = deposit;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropoffLocation() {
        return dropoffLocation;
    }

    public void setDropoffLocation(String dropoffLocation) {
        this.dropoffLocation = dropoffLocation;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Date deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public Date getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getBillingCycle() {
        return billingCycle;
    }

    public void setBillingCycle(String billingCycle) {
        this.billingCycle = billingCycle;
    }

    public Date getServiceFeeSummarySentAt() {
        return serviceFeeSummarySentAt;
    }

    public void setServiceFeeSummarySentAt(Date serviceFeeSummarySentAt) {
        this.serviceFeeSummarySentAt = serviceFeeSummarySentAt;
    }

    @XmlTransient
    public Collection<AdditionalFees> getAdditionalFeesCollection() {
        return additionalFeesCollection;
    }

    public void setAdditionalFeesCollection(Collection<AdditionalFees> additionalFeesCollection) {
        this.additionalFeesCollection = additionalFeesCollection;
    }

    @XmlTransient
    public Collection<Payments> getPaymentsCollection() {
        return paymentsCollection;
    }

    public void setPaymentsCollection(Collection<Payments> paymentsCollection) {
        this.paymentsCollection = paymentsCollection;
    }

    @XmlTransient
    public Collection<Invoices> getInvoicesCollection() {
        return invoicesCollection;
    }

    public void setInvoicesCollection(Collection<Invoices> invoicesCollection) {
        this.invoicesCollection = invoicesCollection;
    }

    @XmlTransient
    public Collection<VehicleReplacements> getVehicleReplacementsCollection() {
        return vehicleReplacementsCollection;
    }

    public void setVehicleReplacementsCollection(Collection<VehicleReplacements> vehicleReplacementsCollection) {
        this.vehicleReplacementsCollection = vehicleReplacementsCollection;
    }

    @XmlTransient
    public Collection<Cancellations> getCancellationsCollection() {
        return cancellationsCollection;
    }

    public void setCancellationsCollection(Collection<Cancellations> cancellationsCollection) {
        this.cancellationsCollection = cancellationsCollection;
    }

    @XmlTransient
    public Collection<DamageReports> getDamageReportsCollection() {
        return damageReportsCollection;
    }

    public void setDamageReportsCollection(Collection<DamageReports> damageReportsCollection) {
        this.damageReportsCollection = damageReportsCollection;
    }

    public Cars getCarId() {
        return carId;
    }

    public void setCarId(Cars carId) {
        this.carId = carId;
    }

    public Customers getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customers customerId) {
        this.customerId = customerId;
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
        if (!(object instanceof Bookings)) {
            return false;
        }
        Bookings other = (Bookings) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Bookings[ id=" + id + " ]";
    }
    
}
