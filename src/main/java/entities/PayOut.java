package entities;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Data

public class PayOut {
    @Id
    @GeneratedValue
    private int po_id;

    private String po_title;
    private String po_paymentType;
    private double po_paymentAmount;
    private String po_paymentDetail;


}
