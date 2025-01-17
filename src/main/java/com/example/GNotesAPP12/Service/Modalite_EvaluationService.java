package com.example.GNotesAPP12.Service;

import com.example.GNotesAPP12.Model.Modalite_Evaluation;
import com.example.GNotesAPP12.Repo.Modalite_EvaluationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Modalite_EvaluationService {

    @Autowired
    private Modalite_EvaluationRepo modalite_EvaluationRepo;

    public List<Modalite_Evaluation> getAllModalite_Evaluations_byElement(Long elementCode) {
        return modalite_EvaluationRepo.findModalite_EvaluationByElementCode(elementCode);
    }
}
