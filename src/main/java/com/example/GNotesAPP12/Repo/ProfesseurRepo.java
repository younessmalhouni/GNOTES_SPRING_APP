package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Etudiant;
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

    @Query("SELECT DISTINCT e FROM Etudiant e " +
            "JOIN e.filliere f " +
            "JOIN f.modules m " +
            "JOIN m.elements el " +
            "WHERE el.professeur.code = :professeurCode")
    List<Etudiant> EtudiantsByProfesseur(@Param("professeurCode") Long professeurCode);


    @Query("SELECT DISTINCT e FROM Element e " +
            "JOIN e.module m " +
            "JOIN m.filliere f " +
            "WHERE e.professeur.code = :professeurCode " +
            "AND (:searchTerm IS NULL OR LOWER(e.nomElement) LIKE %:searchTerm%) " +
            "AND (:filliereId IS NULL OR f.idFilliere = :filliereId) " +
            "AND (:semestreId IS NULL OR m.semestre.id_Semestre = :semestreId) " +
            "AND (:codeModule IS NULL OR m.codeModule = :codeModule)")
    List<Element> ElementsByProfesseur(@Param("professeurCode") Long professeurCode,
                                       @Param("searchTerm") String searchTerm,
                                       @Param("filliereId") Long filliereId,
                                       @Param("semestreId") Long semestreId,
                                       @Param("codeModule") Long codeModule);




    @Query("SELECT DISTINCT e FROM Etudiant e " +
            "JOIN e.filliere f " +
            "JOIN f.modules m " +
            "JOIN m.elements el " +
            "WHERE el.professeur.code = :professeurCode " +
            "AND (:searchTerm IS NULL OR LOWER(e.nomEtudiant) LIKE %:searchTerm% OR LOWER(e.prenomEtudiant) LIKE %:searchTerm%) " +
            "AND (:filliereId IS NULL OR f.idFilliere = :filliereId) " +
            "AND (:semestreId IS NULL OR e.semestre.id_Semestre = :semestreId)" +
            "AND (:codeModule IS NULL OR m.codeModule = :codeModule)"+
            "AND (:elementId IS NULL OR el.idElement = :elementId)")

    List<Etudiant> findByFilters(
            @Param("professeurCode") Long professeurCode,
            @Param("searchTerm") String searchTerm,
            @Param("filliereId") Long filliereId,
            @Param("semestreId") Long semestreId,
            @Param("codeModule") Long codeModule,
            @Param("elementId") Long elementId
    );


    //Liste des elements du etudiant par professeur
    @Query("select el from Element el " +
            "join el.module m " +
            "join m.filliere f " +
            "join f.etudiants e " +
            "where el.professeur.code = :professeurCode " +
            "and e.codeEtudiant = :etudiantCode " )
    List<Element> getElementsByEtudiantandProf(@Param("professeurCode") Long professeurCode,
                                       @Param("etudiantCode") Long etudiantCode);


    //Nombre Total des Professeurs
    @Query("SELECT COUNT(p) FROM Professeur p")
    Long NbrProfesseurs();

}