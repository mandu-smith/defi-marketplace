;; Defi Marketplace - NFT Collateralized Finance Platform
;;
;; Title: Defi Marketplace - NFT Finance & Staking Protocol
;;
;; Summary: A comprehensive Bitcoin-native NFT platform enabling collateralized 
;; minting, marketplace trading, fractional ownership, and yield-generating staking
;; with advanced risk management and protocol governance.
;;
;; Description: Defi Marketplace revolutionizes digital asset management on Bitcoin's
;; Layer 2 by combining traditional NFT functionality with sophisticated DeFi
;; mechanisms. Users can mint NFTs with STX collateral backing, trade on an
;; integrated marketplace with protocol fees, fractionalize ownership for
;; democratized access, and stake assets to earn consistent yields. The platform
;; implements robust collateral ratios, overflow protection, and comprehensive
;; access controls to ensure secure, scalable operations while maintaining
;; Bitcoin's security guarantees through Stacks integration.
;;

;; CONSTANTS & ERROR HANDLING

(define-constant contract-owner tx-sender)

;; Access Control Errors
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; Financial Operation Errors
(define-constant err-insufficient-balance (err u102))
(define-constant err-insufficient-collateral (err u106))

;; NFT Operation Errors
(define-constant err-invalid-token (err u103))
(define-constant err-listing-not-found (err u104))
(define-constant err-invalid-price (err u105))

;; Staking System Errors
(define-constant err-already-staked (err u107))
(define-constant err-not-staked (err u108))

;; Validation Errors
(define-constant err-invalid-percentage (err u109))
(define-constant err-invalid-uri (err u110))
(define-constant err-invalid-recipient (err u111))
(define-constant err-overflow (err u112))

;; PROTOCOL CONFIGURATION

(define-data-var min-collateral-ratio uint u150) ;; 150% minimum collateral ratio
(define-data-var protocol-fee uint u25) ;; 2.5% fee in basis points
(define-data-var total-staked uint u0) ;; Total number of staked NFTs
(define-data-var yield-rate uint u50) ;; 5% annual yield rate in basis points
(define-data-var total-supply uint u0) ;; Total NFTs minted

;; DATA STRUCTURES

;; Core NFT Registry
(define-map tokens
  { token-id: uint }
  {
    owner: principal,
    uri: (string-ascii 256),
    collateral: uint,
    is-staked: bool,
    stake-timestamp: uint,
    fractional-shares: uint,
  }
)

;; Marketplace Listings Registry
(define-map token-listings
  { token-id: uint }
  {
    price: uint,
    seller: principal,
    active: bool,
  }
)

;; Fractional Ownership Registry
(define-map fractional-ownership
  {
    token-id: uint,
    owner: principal,
  }
  { shares: uint }
)

;; Staking Rewards Registry
(define-map staking-rewards
  { token-id: uint }
  {
    accumulated-yield: uint,
    last-claim: uint,
  }
)