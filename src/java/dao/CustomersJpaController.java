package dao;

import java.io.Serializable;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Query;
import jakarta.persistence.EntityNotFoundException;
import model.Customers;

public class CustomersJpaController implements Serializable {
    private EntityManagerFactory emf = null;

    public CustomersJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Customers customer) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(customer);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Customers customer) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            customer = em.merge(customer);
            em.getTransaction().commit();
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
            Customers customer;
            try {
                customer = em.getReference(Customers.class, id);
                customer.getId();
            } catch (EntityNotFoundException enfe) {
                throw new Exception("The customer with id " + id + " no longer exists.", enfe);
            }
            em.remove(customer);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public Customers findCustomers(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Customers.class, id);
        } finally {
            em.close();
        }
    }

    public List<Customers> findCustomersEntities() {
        return findCustomersEntities(true, -1, -1);
    }

    public List<Customers> findCustomersEntities(int maxResults, int firstResult) {
        return findCustomersEntities(false, maxResults, firstResult);
    }

    private List<Customers> findCustomersEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            Query q = em.createQuery("select o from Customers o");
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public int getCustomersCount() {
        EntityManager em = getEntityManager();
        try {
            return ((Long) em.createQuery("select count(o) from Customers o").getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    // Custom finder
    public Customers findByEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            List<Customers> list = em.createNamedQuery("Customers.findByEmail", Customers.class)
                .setParameter("email", email)
                .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public Customers findByPhone(String phone) {
        EntityManager em = getEntityManager();
        try {
            List<Customers> list = em.createNamedQuery("Customers.findByPhone", Customers.class)
                .setParameter("phone", phone)
                .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }
}
