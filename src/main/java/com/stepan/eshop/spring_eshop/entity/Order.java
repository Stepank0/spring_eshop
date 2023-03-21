package com.stepan.eshop.spring_eshop.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "orders")
public class Order {
    private static final String SEQ_NAME = "order_seq";

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = SEQ_NAME)
    @SequenceGenerator(name =SEQ_NAME, sequenceName = SEQ_NAME)
    private Long id;
    @CreationTimestamp // дата создания сразу будет записываться в это поле
    private LocalDateTime created;
    @UpdateTimestamp // автоматически обновляет дату
    private LocalDateTime updated;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    private BigDecimal sum;
    private String address;
    @OneToMany(cascade = CascadeType.ALL)
    private List<OrderDetails> details;
    @Enumerated(EnumType.STRING)
    private OrderStatus status;
}
