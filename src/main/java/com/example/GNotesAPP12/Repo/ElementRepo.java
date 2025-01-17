package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Element;
import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ElementRepo extends JpaRepository<Element, String> {
    @Query("SELECT e FROM Element e WHERE " +
            "(:moduleId IS NULL OR e.module.codeModule = :moduleId) AND " +
            "(:profId IS NULL OR e.professeur.code = :profId) AND " +
            "(:searchTerm IS NULL OR LOWER(e.nomElement) LIKE LOWER(CONCAT('%', :searchTerm, '%')))")
    List<Element> findElementsWithFilters(
            @Param("moduleId") String moduleId,
            @Param("profId") String profId,
            @Param("searchTerm") String searchTerm
    );


    @Query("select sum(m.coeffecient) from Modalite_Evaluation m where m.element.idElement = :elementCode")
    Double SommeCoefElement(Long elementCode);

    @Query("select el from Element el where el.idElement=:id")
    Element ElementExistant(Long id);

}
