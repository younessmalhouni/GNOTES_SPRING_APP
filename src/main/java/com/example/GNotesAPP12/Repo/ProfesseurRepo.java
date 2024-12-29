package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Professeur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProfesseurRepo extends JpaRepository<Professeur, String> {

    @Query("SELECT DISTINCT p.specialite FROM Professeur p")
    List<String> findAllSpecialities();

    @Query("SELECT p FROM Professeur p WHERE " +
            "(:searchTerm IS NULL OR :searchTerm = '' OR " +
            "LOWER(p.nom) LIKE LOWER(CONCAT(:searchTerm, '%')) OR " +
            "LOWER(p.prenom) LIKE LOWER(CONCAT(:searchTerm, '%'))) " +
            "AND (:specialite IS NULL OR :specialite = '' OR " +
            "p.specialite = :specialite)")
    List<Professeur> searchProfesseurs(
            @Param("searchTerm") String searchTerm,
            @Param("specialite") String specialite
    );
}