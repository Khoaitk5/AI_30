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
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "Models")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Models.findAll", query = "SELECT m FROM Models m"),
    @NamedQuery(name = "Models.findById", query = "SELECT m FROM Models m WHERE m.id = :id"),
    @NamedQuery(name = "Models.findByModel", query = "SELECT m FROM Models m WHERE m.model = :model"),
    @NamedQuery(name = "Models.findByRentalPricePerDay", query = "SELECT m FROM Models m WHERE m.rentalPricePerDay = :rentalPricePerDay"),
    @NamedQuery(name = "Models.findByRentalPricePerMonth", query = "SELECT m FROM Models m WHERE m.rentalPricePerMonth = :rentalPricePerMonth"),
    @NamedQuery(name = "Models.findByDepositPerDay", query = "SELECT m FROM Models m WHERE m.depositPerDay = :depositPerDay"),
    @NamedQuery(name = "Models.findByDepositPerMonth", query = "SELECT m FROM Models m WHERE m.depositPerMonth = :depositPerMonth"),
    @NamedQuery(name = "Models.findBySeats", query = "SELECT m FROM Models m WHERE m.seats = :seats"),
    @NamedQuery(name = "Models.findByRange", query = "SELECT m FROM Models m WHERE m.range = :range"),
    @NamedQuery(name = "Models.findByVehicleType", query = "SELECT m FROM Models m WHERE m.vehicleType = :vehicleType"),
    @NamedQuery(name = "Models.findByFeatures", query = "SELECT m FROM Models m WHERE m.features = :features")})
public class Models implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "Model")
    private String model;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "RentalPricePerDay")
    private BigDecimal rentalPricePerDay;
    @Column(name = "RentalPricePerMonth")
    private BigDecimal rentalPricePerMonth;
    @Column(name = "DepositPerDay")
    private BigDecimal depositPerDay;
    @Column(name = "DepositPerMonth")
    private BigDecimal depositPerMonth;
    @Column(name = "Seats")
    private Integer seats;
    @Size(max = 50)
    @Column(name = "Range")
    private String range;
    @Size(max = 50)
    @Column(name = "VehicleType")
    private String vehicleType;
    @Size(max = 2147483647)
    @Column(name = "Features")
    private String features;
    @OneToMany(mappedBy = "vehicleModelId")
    private Collection<Cars> carsCollection;

    public Models() {
    }

    public Models(String id) {
        this.id = id;
    }

    public Models(String id, String model) {
        this.id = id;
        this.model = model;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public BigDecimal getRentalPricePerDay() {
        return rentalPricePerDay;
    }

    public void setRentalPricePerDay(BigDecimal rentalPricePerDay) {
        this.rentalPricePerDay = rentalPricePerDay;
    }

    public BigDecimal getRentalPricePerMonth() {
        return rentalPricePerMonth;
    }

    public void setRentalPricePerMonth(BigDecimal rentalPricePerMonth) {
        this.rentalPricePerMonth = rentalPricePerMonth;
    }

    public BigDecimal getDepositPerDay() {
        return depositPerDay;
    }

    public void setDepositPerDay(BigDecimal depositPerDay) {
        this.depositPerDay = depositPerDay;
    }

    public BigDecimal getDepositPerMonth() {
        return depositPerMonth;
    }

    public void setDepositPerMonth(BigDecimal depositPerMonth) {
        this.depositPerMonth = depositPerMonth;
    }

    public Integer getSeats() {
        return seats;
    }

    public void setSeats(Integer seats) {
        this.seats = seats;
    }

    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    @XmlTransient
    public Collection<Cars> getCarsCollection() {
        return carsCollection;
    }

    public void setCarsCollection(Collection<Cars> carsCollection) {
        this.carsCollection = carsCollection;
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
        if (!(object instanceof Models)) {
            return false;
        }
        Models other = (Models) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Models[ id=" + id + " ]";
    }
    
}
