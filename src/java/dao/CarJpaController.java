package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import model.Cars;
import java.util.List;

public class CarJpaController {

    private final EntityManagerFactory emf;

    public CarJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Create a new car
    public void create(Cars car) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(car);
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

    // Update an existing car
    public void edit(Cars car) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            car = em.merge(car);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = car.getId();
                if (findCars(id) == null) {
                    throw new EntityNotFoundException("The car with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    // Update car status to maintenance
    public void updateStatusToMaintenance(String id) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cars car = em.find(Cars.class, id);
            if (car == null) {
                throw new EntityNotFoundException("The car with id " + id + " no longer exists.");
            }
            car.setStatus("MAINTENANCE");
            em.merge(car);
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

    // Update car status to available
    public void updateStatusToAvailable(String id) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cars car = em.find(Cars.class, id);
            if (car == null) {
                throw new EntityNotFoundException("The car with id " + id + " no longer exists.");
            }
            car.setStatus("AVAILABLE");
            em.merge(car);
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

    // Find car by ID
    public Cars findCars(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Cars.class, id);
        } finally {
            em.close();
        }
    }

    // Find all cars
    public List<Cars> findCarsEntities() {
        return findCarsEntities(true, -1, -1);
    }

    public List<Cars> findCarsEntities(int maxResults, int firstResult) {
        return findCarsEntities(false, maxResults, firstResult);
    }

    private List<Cars> findCarsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Cars.class));
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

    // Get count of all cars
    public int getCarsCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Cars> rt = cq.from(Cars.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public List<Cars> findCarsByModelAndStatus(String modelId, String status) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Cars c WHERE c.vehicleModelId.id = :modelId AND c.status = :status", Cars.class)
                    .setParameter("modelId", modelId)
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // Check for duplicate license plate
    public boolean isLicensePlateDuplicate(String licensePlate, String excludeCarId) {
        EntityManager em = getEntityManager();
        try {
            Query query = em.createQuery("SELECT c FROM Cars c WHERE c.licensePlate = :licensePlate AND c.id != :excludeCarId", Cars.class);
            query.setParameter("licensePlate", licensePlate);
            query.setParameter("excludeCarId", excludeCarId != null ? excludeCarId : "");
            return !query.getResultList().isEmpty();
        } finally {
            em.close();
        }
    }

    // Check for duplicate chassis number
    public boolean isChassisNumberDuplicate(String chassisNumber, String excludeCarId) {
        EntityManager em = getEntityManager();
        try {
            Query query = em.createQuery("SELECT c FROM Cars c WHERE c.chassisNumber = :chassisNumber AND c.id != :excludeCarId", Cars.class);
            query.setParameter("chassisNumber", chassisNumber);
            query.setParameter("excludeCarId", excludeCarId != null ? excludeCarId : "");
            return !query.getResultList().isEmpty();
        } finally {
            em.close();
        }
    }
}