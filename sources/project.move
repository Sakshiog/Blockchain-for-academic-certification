module AcademicCertifications::Certification {
    use aptos_framework::signer;
    use aptos_framework::vector;

    // Struct representing a certification.
    struct Certification has store {
        student: address,          // Address of the student
        institution: address,      // Issuing institution
        certificate_id: u64,       // Unique certificate ID
        issued: bool,              // Status of certification (issued or not)
    }

    // Create and issue a certification
    public fun issue_certification(owner: &signer, student: address, certificate_id: u64) {
        let certification = Certification {
            student,
            institution: signer::address_of(owner),
            certificate_id,
            issued: true,
        };
        move_to(owner, certification);
    }

    // Verify the validity of a certification
    public fun verify_certification(certificate_id: u64, student: address): bool acquires Certification {
        let cert = borrow_global<Certification>(student);
        // Check if the certification matches the student and is valid
        cert.certificate_id == certificate_id && cert.issued
    }
}
