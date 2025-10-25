package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.Query;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import model.Models;
import java.util.List;

public class ModelJpaController {

    private final EntityManagerFactory emf;

    public ModelJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Models findModels(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Models.class, id);
        } finally {
            em.close();
        }
    }

    public List<Models> findModelsEntities() {
        return findModelsEntities(true, -1, -1);
    }

    public List<Models> findModelsEntities(int maxResults, int firstResult) {
        return findModelsEntities(false, maxResults, firstResult);
    }

    private List<Models> findModelsEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Models.class));
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
}