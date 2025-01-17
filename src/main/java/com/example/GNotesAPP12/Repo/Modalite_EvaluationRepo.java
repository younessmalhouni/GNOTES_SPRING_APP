package com.example.GNotesAPP12.Repo;

import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface Modalite_EvaluationRepo extends JpaRepository<Modalite_Evaluation, Long> {

    @Query("select m from Modalite_Evaluation m where m.element.idElement = :elementCode")
    List<Modalite_Evaluation> findModalite_EvaluationByElementCode(@Param("elementCode") Long elementCode);
}

