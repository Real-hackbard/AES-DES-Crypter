# AES-DES-Crypter:

```ruby
Compiler    : Delphi7 (or Higher)
Components  : None
Discription : AES String Crypter
Last Update : 08/2025
License     : Freeware
```

The Advanced Encryption Standard (AES), also known by its original name Rijndael , is a specification for the encryption of electronic data established by the U.S. National Institute of Standards and Technology (NIST).

AES is a variant of the Rijndael block cipher developed by two Belgian cryptographers, Joan Daemen and Vincent Rijmen, who submitted a proposal to NIST during the AES selection process.Rijndael is a family of ciphers with different key and block sizes. For AES, NIST selected three members of the Rijndael family, each with a block size of 128 bits, but three different key lengths: 128, 192 and 256 bits.



![AES DES Crypting](https://github.com/user-attachments/assets/82c09e2e-6f72-4062-a672-bff3a7b0586d)



AES has been adopted by the U.S. government. It supersedes the Data Encryption Standard (DES), which was published in 1977. The algorithm described by AES is a symmetric-key algorithm, meaning the same key is used for both encrypting and decrypting the data.

In the United States, AES was announced by the NIST as U.S. FIPS PUB 197 (FIPS 197) on November 26, 2001.[6] This announcement followed a five-year standardization process in which fifteen competing designs were presented and evaluated, before the Rijndael cipher was selected as the most suitable.

AES is included in the ISO/IEC 18033-3 standard. AES became effective as a U.S. federal government standard on May 26, 2002, after approval by U.S. Secretary of Commerce Donald Evans. AES is available in many different encryption packages, and is the first (and only) publicly accessible cipher approved by the U.S. National Security Agency (NSA) for top secret information when used in an NSA approved cryptographic module.

### The Advanced Encryption Standard (AES) is defined in each of:

* FIPS PUB 197: Advanced Encryption Standard (AES)[6]
* ISO/IEC 18033-3: Block ciphers.

AES is based on a design principle known as a substitution–permutation network, and is efficient in both software and hardware. Unlike its predecessor DES, AES does not use a Feistel network. AES is a variant of Rijndael, with a fixed block size of 128 bits, and a key size of 128, 192, or 256 bits. By contrast, Rijndael per se is specified with block and key sizes that may be any multiple of 32 bits, with a minimum of 128 and a maximum of 256 bits. Most AES calculations are done in a particular finite field.

The key size used for an AES cipher specifies the number of transformation rounds that convert the input, called the plaintext, into the final output, called the ciphertext. The number of rounds are as follows:

* 10 rounds for 128-bit keys.
* 12 rounds for 192-bit keys.
* 14 rounds for 256-bit keys.

Each round consists of several processing steps, including one that depends on the encryption key itself. A set of reverse rounds are applied to transform ciphertext back into the original plaintext using the same encryption key.

### High-level description of the algorithm:

* KeyExpansion – round keys are derived from the cipher key using the AES key schedule. AES requires a separate 128-bit round key block for each round plus one more.

### Initial round key addition:

* AddRoundKey – each byte of the state is combined with a byte of the round key using bitwise xor.
* 9, 11 or 13 rounds:
* SubBytes – a non-linear substitution step where each byte is replaced with another according to a lookup table.
* ShiftRows – a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
* MixColumns – a linear mixing operation which operates on the columns of the state, combining the four bytes in each column.

The National Security Agency (NSA) reviewed all the AES finalists, including Rijndael, and stated that all of them were secure enough for U.S. Government non-classified data. In June 2003, the U.S. Government announced that AES could be used to protect classified information:

The design and strength of all key lengths of the AES algorithm (i.e., 128, 192 and 256) are sufficient to protect classified information up to the SECRET level. TOP SECRET information will require use of either the 192 or 256 key lengths. The implementation of AES in products intended to protect national security systems and/or information must be reviewed and certified by NSA prior to their acquisition and use.

AES has 10 rounds for 128-bit keys, 12 rounds for 192-bit keys, and 14 rounds for 256-bit keys.
