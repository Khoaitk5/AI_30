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
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author DELL
 */
@Entity
@Table(name = "Customers")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Customers.findAll", query = "SELECT c FROM Customers c"),
    @NamedQuery(name = "Customers.findById", query = "SELECT c FROM Customers c WHERE c.id = :id"),
    @NamedQuery(name = "Customers.findByFullName", query = "SELECT c FROM Customers c WHERE c.fullName = :fullName"),
    @NamedQuery(name = "Customers.findByEmail", query = "SELECT c FROM Customers c WHERE c.email = :email"),
    @NamedQuery(name = "Customers.findByPhone", query = "SELECT c FROM Customers c WHERE c.phone = :phone"),
    @NamedQuery(name = "Customers.findByAddress", query = "SELECT c FROM Customers c WHERE c.address = :address"),
    @NamedQuery(name = "Customers.findByLicenseNumber", query = "SELECT c FROM Customers c WHERE c.licenseNumber = :licenseNumber"),
    @NamedQuery(name = "Customers.findByLicenseExpiry", query = "SELECT c FROM Customers c WHERE c.licenseExpiry = :licenseExpiry"),
    @NamedQuery(name = "Customers.findByIdCardNumber", query = "SELECT c FROM Customers c WHERE c.idCardNumber = :idCardNumber"),
    @NamedQuery(name = "Customers.findByDateOfBirth", query = "SELECT c FROM Customers c WHERE c.dateOfBirth = :dateOfBirth"),
    @NamedQuery(name = "Customers.findByMembershipLevel", query = "SELECT c FROM Customers c WHERE c.membershipLevel = :membershipLevel"),
    @NamedQuery(name = "Customers.findByStatus", query = "SELECT c FROM Customers c WHERE c.status = :status"),
    @NamedQuery(name = "Customers.findByCreatedAt", query = "SELECT c FROM Customers c WHERE c.createdAt = :createdAt"),
    @NamedQuery(name = "Customers.findByUpdatedAt", query = "SELECT c FROM Customers c WHERE c.updatedAt = :updatedAt"),
    @NamedQuery(name = "Customers.findBySensitiveDataEncrypted", query = "SELECT c FROM Customers c WHERE c.sensitiveDataEncrypted = :sensitiveDataEncrypted"),
    @NamedQuery(name = "Customers.findBySensitiveDataFields", query = "SELECT c FROM Customers c WHERE c.sensitiveDataFields = :sensitiveDataFields")})
public class Customers implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Id")
    private String id;
    @Size(max = 100)
    @Column(name = "FullName")
    private String fullName;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 100)
    @Column(name = "Email")
    private String email;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Size(max = 20)
    @Column(name = "Phone")
    private String phone;
    @Size(max = 200)
    @Column(name = "Address")
    private String address;
    @Size(max = 50)
    @Column(name = "LicenseNumber")
    private String licenseNumber;
    @Column(name = "LicenseExpiry")
    @Temporal(TemporalType.DATE)
    private Date licenseExpiry;
    @Size(max = 50)
    @Column(name = "IdCardNumber")
    private String idCardNumber;
    @Column(name = "DateOfBirth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    @Size(max = 50)
    @Column(name = "MembershipLevel")
    private String membershipLevel;
    @Size(max = 50)
    @Column(name = "Status")
    private String status;
    @Column(name = "CreatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Column(name = "UpdatedAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;
    @Column(name = "SensitiveDataEncrypted")
    private Boolean sensitiveDataEncrypted;
    @Size(max = 2147483647)
    @Column(name = "SensitiveDataFields")
    private String sensitiveDataFields;
    @OneToMany(mappedBy = "customerId")
    private Collection<Users> usersCollection;
    @OneToMany(mappedBy = "customerId")
    private Collection<Bookings> bookingsCollection;

    public Customers() {
    }

    public Customers(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public Date getLicenseExpiry() {
        return licenseExpiry;
    }

    public void setLicenseExpiry(Date licenseExpiry) {
        this.licenseExpiry = licenseExpiry;
    }

    public String getIdCardNumber() {
        return idCardNumber;
    }

    public void setIdCardNumber(String idCardNumber) {
        this.idCardNumber = idCardNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Boolean getSensitiveDataEncrypted() {
        return sensitiveDataEncrypted;
    }

    public void setSensitiveDataEncrypted(Boolean sensitiveDataEncrypted) {
        this.sensitiveDataEncrypted = sensitiveDataEncrypted;
    }

    public String getSensitiveDataFields() {
        return sensitiveDataFields;
    }

    public void setSensitiveDataFields(String sensitiveDataFields) {
        this.sensitiveDataFields = sensitiveDataFields;
    }

    @XmlTransient
    public Collection<Users> getUsersCollection() {
        return usersCollection;
    }

    public void setUsersCollection(Collection<Users> usersCollection) {
        this.usersCollection = usersCollection;
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
        if (!(object instanceof Customers)) {
            return false;
        }
        Customers other = (Customers) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Customers[ id=" + id + " ]";
    }
    
}
