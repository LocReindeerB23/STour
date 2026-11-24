package com.example.tourbooking.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.NotNull;

public class OrderDTO {
    
    @NotNull(message = "Tour ID không hợp lệ")
    private Long tourId;

    @NotBlank(message = "Họ và tên không được để trống")
    private String fullName;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    private String email;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^[0-9]{9,11}$", message = "Số điện thoại phải từ 9 đến 11 chữ số")
    private String phone;

    @Min(value = 0, message = "Số vé người lớn không được âm")
    @NotNull(message = "Vui lòng nhập số lượng vé người lớn")
    private Integer adultTickets;

    @Min(value = 0, message = "Số vé trẻ em không được âm")
    @NotNull(message = "Vui lòng nhập số lượng vé trẻ em")
    private Integer childrenTickets;

    @NotBlank(message = "Vui lòng chọn phương thức thanh toán")
    private String paymentMethod;
    
    private String specialRequest;
    
    private String promoCode;

    public Long getTourId() { return tourId; }
    public void setTourId(Long tourId) { this.tourId = tourId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Integer getAdultTickets() { return adultTickets; }
    public void setAdultTickets(Integer adultTickets) { this.adultTickets = adultTickets; }

    public Integer getChildrenTickets() { return childrenTickets; }
    public void setChildrenTickets(Integer childrenTickets) { this.childrenTickets = childrenTickets; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getSpecialRequest() { return specialRequest; }
    public void setSpecialRequest(String specialRequest) { this.specialRequest = specialRequest; }

    public String getPromoCode() { return promoCode; }
    public void setPromoCode(String promoCode) { this.promoCode = promoCode; }
}
