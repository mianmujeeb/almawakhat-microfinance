from django.urls import path
from .views import *


urlpatterns = [
    path('applicants', applicants, name='applicants'),
    
    path('applicant/add/general', addApplicantStep1, name='add-applicant-1'),
    path('applicant/add/bank-account/<int:pk>', addApplicantStep2, name='add-applicant-2'),
    path('applicant/add/guarantor/<int:pk>', addApplicantStep3, name='add-applicant-3'),
    
    path('applicant/<int:pk>', editApplicant, name='edit-applicant'),
    
    path('update-applicant-guarantor', editApplicantGuarantor, name="edit-applicant-guarantor"),
    path('delete-applicant-guarantor/<int:pk>', deleteApplicantGuarantor, name="delete-applicant-guarantor"),
    
    path('update-applicant-bank-account', editApplicantBankAccount, name="edit-applicant-bank-account"),
    path('delete-applicant-bank-account/<int:pk>', deleteApplicantBankAccount, name="delete-applicant-bank-account"),
    
    path('applicant-product-detail', applicantProductDetail, name="applicant-product-detail"),
    path('delete-applicant-product/<int:pk>', deleteApplicantProduct, name="delete-applicant-product"),
    
    path('applicant-product-challan/update', updateApplicantProductChallan, name="update-applicant-product-challan"),
    path('delete-applicant-product-challan/<int:pk>', deleteApplicantProductChallan, name="delete-applicant-product-challan"),
    
]