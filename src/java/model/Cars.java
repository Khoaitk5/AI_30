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
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "Cars")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cars.findAll", query = "SELECT c FROM Cars c"),
    @NamedQuery(name = "Cars.findById", query = "SELECT c FROM Cars c WHERE c.id = :id"),
    @NamedQuery(name = "Cars.findByLicensePlate", query = "SELECT c FROM Cars c WHERE c.licensePlate = :licensePlate"),
    @NamedQuery(name = "Cars.findByChassisNumber", query = "SELECT c FROM Cars c WHERE c.chassisNumber = :chassisNumber"),
    @NamedQuery(name = "Cars.findByStatus", query = "SELECT c FROM Cars c WHERE c.status = :status")})
public class Cars implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Size(max = 20)
    @Column(name = "LicensePlate")
    private String licensePlate;
    @Size(max = 50)
    @Column(name = "ChassisNumber")
    private String chassisNumber;
    @Size(max = 50)
    @Column(name = "Status")
    private String status;
    @JoinColumn(name = "ColorId", referencedColumnName = "Id")
    @ManyToOne
    private Colors colorId;
    @JoinColumn(name = "VehicleModelId", referencedColumnName = "Id")
    @ManyToOne
    private Models vehicleModelId;
    @OneToMany(mappedBy = "originalCarId")
    private Collection<VehicleReplacements> vehicleReplacementsCollection;
    @OneToMany(mappedBy = "replacementCarId")
    private Collection<VehicleReplacements> vehicleReplacementsCollection1;
    @OneToMany(mappedBy = "carId")
    private Collection<DamageReports> damageReportsCollection;
    @OneToMany(mappedBy = "carId")
    private Collection<Bookings> bookingsCollection;

    public Cars() {
    }

    public Cars(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getChassisNumber() {
        return chassisNumber;
    }

    public void setChassisNumber(String chassisNumber) {
        this.chassisNumber = chassisNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Colors getColorId() {
        return colorId;
    }

    public void setColorId(Colors colorId) {
        this.colorId = colorId;
    }

    public Models getVehicleModelId() {
        return vehicleModelId;
    }

    public void setVehicleModelId(Models vehicleModelId) {
        this.vehicleModelId = vehicleModelId;
    }

    @XmlTransient
    public Collection<VehicleReplacements> getVehicleReplacementsCollection() {
        return vehicleReplacementsCollection;
    }

    public void setVehicleReplacementsCollection(Collection<VehicleReplacements> vehicleReplacementsCollection) {
        this.vehicleReplacementsCollection = vehicleReplacementsCollection;
    }

    @XmlTransient
    public Collection<VehicleReplacements> getVehicleReplacementsCollection1() {
        return vehicleReplacementsCollection1;
    }

    public void setVehicleReplacementsCollection1(Collection<VehicleReplacements> vehicleReplacementsCollection1) {
        this.vehicleReplacementsCollection1 = vehicleReplacementsCollection1;
    }

    @XmlTransient
    public Collection<DamageReports> getDamageReportsCollection() {
        return damageReportsCollection;
    }

    public void setDamageReportsCollection(Collection<DamageReports> damageReportsCollection) {
        this.damageReportsCollection = damageReportsCollection;
    }

    @XmlTransient
    public Collection<Bookings> getBookingsCollection() {
        return bookingsCollection;
    }

    public void setBookingsCollection(Collection<Bookings> bookingsCollection) {
        this.bookingsCollection = bookingsCollection;
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
        if (!(object instanceof Cars)) {
            return false;
        }
        Cars other = (Cars) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Cars[ id=" + id + " ]";
    }
    
}
