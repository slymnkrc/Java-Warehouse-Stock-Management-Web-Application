package entities;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int py_id;

    private double py_DebtAmount;
    private double py_PaymentAmount;
    private double py_RemainAmount;

    @Column(length = 100)
    private String py_Detail = "Sipariş Tamamlandı";

    private int ba_id;

    private int cu_id;
}
