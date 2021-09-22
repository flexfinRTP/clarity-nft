(impl-trait .sip009-nft-trait.sip009-nft-trait)

(define-non-fungible-token pogs uint)

(define-constant contract-owner tx-sender)
(define-constant err-not-token-owner (err u100))
(define-constant err-not-contract-owner (err u101))

(define-data-var last-token-id uint u0)

(define-read-only (get-last-token-id)
    (ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint))
    (ok none) ;;"https:// or ipfs storage link"
)

(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? pogs token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    (begin
    (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (nft-transfer? pogs token-id sender recipient)
    )
)

(define-public (mint (recipient principal))
    (let 
        (
            ;;Variable expressions
            (token-id (+ (var-get last-token-id) u1))
        )
        ;;Inner expressions
        (asserts! (is-eq tx-sender contract-owner) err-not-contract-owner)
        (try! (nft-mint? pogs token-id recipient))
        (var-set last-token-id token-id)
        (ok true)
    )
)
;; insert into mint func-max # of nfts (asserts! token-id > u1000 total ever) boom wallet nft will show up
;; create your own SIP-009 compliant NFT
;; create your own SIP-010 token