package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import model.Bookings;
import java.util.Date;
import java.util.List;

public class BookingsJpaController {

    private final EntityManagerFactory emf;

    public BookingsJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Bookings booking) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(booking);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Bookings booking) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            booking = em.merge(booking);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = booking.getId();
                if (findBookings(id) == null) {
                    throw new EntityNotFoundException("The booking with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Bookings booking;
            try {
                booking = em.getReference(Bookings.class, id);
                booking.getId();
            } catch (EntityNotFoundException enfe) {
                throw new Exception("The booking with id " + id + " no longer exists.", enfe);
            }
            em.remove(booking);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public Bookings findBookings(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Bookings.class, id);
        } finally {
            em.close();
        }
    }

    public List<Bookings> findBookingsEntities() {
        return findBookingsEntities(true, -1, -1);
    }

    public List<Bookings> findBookingsEntities(int maxResults, int firstResult) {
        return findBookingsEntities(false, maxResults, firstResult);
    }

    private List<Bookings> findBookingsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Bookings.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public int getBookingsCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Bookings> rt = cq.from(Bookings.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public List<Bookings> findBookingsByCarAndDateRange(String carId, Date startDate, Date endDate) {
        EntityManager em = getEntityManager();
        try {
            Query query = em.createQuery(
                "SELECT b FROM Bookings b WHERE b.carId.id = :carId AND b.status IN ('PENDING', 'COMPLETED') " +
                "AND ((b.startDate <= :endDate AND b.endDate >= :startDate) OR " +
                "(b.startDate >= :startDate AND b.startDate <= :endDate) OR " +
                "(b.endDate >= :startDate AND b.endDate <= :endDate))");
            query.setParameter("carId", carId);
            query.setParameter("startDate", startDate);
            query.setParameter("endDate", endDate);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}