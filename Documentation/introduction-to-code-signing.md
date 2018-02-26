# Introduction to Code Signing

## Certificate Signing Request
The developer's **private key** is used to sign the **Certificate Signing Request**.

## Signing Certificate
The **Certificate Signing Request** contains the developer's information and **public key**.

**Apple's Certificate Authority** recieves the **Certificate Signing Request** and will **generate and sign** an **identity certificate** for the developer.

The **developer recieves** the **identity certificate** and **uses it to sign applications** using this certificate and their private key.

**Software** that is **signed by the identity certificate is** said to be **trusted by the signer**.

**Software** installed on **iOS devices** have their certificates **validated against** the **Certificate Authority** that signs developer's certificates.

 **This validates** the chain of:
 
- Software being trusted by the developer
- The developer is trusted by Apple
- The device trusts Apple

Therefore, the **device trusts** software from **the developer**.

## Signing a Binary

Part of the requirement of **building iOS software** is that you **must sign** all of the **software** that you **are going to be deploying to an iOS device**. 

This is due to the strict security policies that are enforced by the operating system. **Xcode** helpfully **integrates this step** into building applications for us by **invoking codesign** on the **executable binary**. 

**This will generate** a **signature** of the contents of the executable code in the binary **using** the **private key associated with** the **identity certificate** that was **created by Apple**. 

The **generated signature** will then be **embedded into the executable binary** to allow for it **to be validated**. This will ensure that the code that the application has cannot be modified without causing a validation error against the embedded signature. 

Since **iOS applications are** comprised of **more than the executable binary**, this single embedded signature is not enough to ensure integrity of the entire application.

**Applications are seen as files with the .app extension**. This is called a **"bundle"**. 

**Bundles** are directories that **contain** a **structured format** and **layout of contents**. 
By giving directories file extensions, it allows them to be registered with the system to be loaded by another program.

So **to ensure** that **not only the executable binary remains unmodified**, **but also** the **data and assets** that are used while it is being run, **a new directory is added to the application bundle**. This new directory is **named _CodeSignature**, and contains a CodeResources file. **This** file **is a plist** that **lists all** of the **files** that are **included as part of the bundle** and **gives each file a hash**. This hash is **used to validate the contents** of the bundle **remain unchanged**. Some resources can be configured to be updated and omitted as part of the resource check, to prevent an application from invalidating its own signature.

This process allows developers to perform a build and sign it immediately and know that the binary that they plan to distribute is the same as the one that was originally built.

## Provisioning Profiles

While the certificates are used to validate the authenticity of the signer of an application, **there is an additional component** that is **used to validate that the application** is **allowed** to be installed **on a specific device**. This component is called the provisioning profile. 

A **provisioning profile** is a **plist file** that is **cryptographically signed by Apple's Certificate Authority to ensure** it **cannot be modified after being created**. This allows Apple to have complete control over the deployment mechanism that is used on iOS.

A provisioning profile contains some specific information for enabling deployment of an application:

- certificates that can be used to sign the application
- bundle identifier to be matched against the application
- method of deployment (Enterprise-style or based on device UDID)
- team identifier
- sandbox entitlements
- expiration date of the installable

All of **these attributes** are used in **determining** of **the device is allowed to install the application that the provisioning profile was bundled in**. This restricts who can install a development-signed application and allows for the source of any signed application to be traced back to the account that the certificate was created from on the Apple Developer Portal.

The **purpose** of the provisioning profile **is to allow for specific configuration of an installable to be secure**, while also not making it prohibitive to update that configuration at any time. Within the Apple Developer Portal, **you are allowed to edit and regenerate provisioning profiles at any time**. Doing this doesn't invalidate the previous profile, it only generates a new one with different contents based on what you modified.

## Signature Validation

When **developing software for iOS**, you will **build and sign** the **application on your computer**, then Xcode will talk to an iOS device that is connected via USB. It will perform a authentication handshake with the iOS device, then start communicating with it over a local secured socket connection via the USB interface. At this point the iOS device is informed that we want to install a software package, and begin sending the data over to the device. The iOS device will receive this data and reconstruct the application in a temporary sandboxed environment. Once the application has been completely recieved, the **operating system** will **validate** that the **application is signed and is capable of being installed onto this device**.

Once the application is determined to be from a trusted source, it is validated against the provisioning profile to ensure that it can be installed and run on this device. Each iOS device has a unique identifier, the UDID (Unique Device IDentifier). This identifier is composed by taking the SHA1 of a string composed of the following components:

- serial number
- ECID (aka UniqueChipID, this is unique to every device)
- MAC address of the wifi card
- MAC address of the bluetooth card

This identifier contains enough information to uniquely identify all iOS devices. The identifier is required to be used by developers when registering specific devices with their account on the Apple Developer Portal. Each account is restricted to a specific number of devices that are allowed to be registered. A provisioning profile can include any number of identifiers of the devices registered to this pool. This restricts developers to only being able to install devices that are register to their pool of devices. If the device's UDID doesn't match any of the identifiers that are registered with the provisioning profile, then the app will not be installed as it is not approved. 

**If** the **application's signature** and **provisioning profile** both **pass the validation step**, then a true sandbox container is created for that application to reside in. **A new directory is created on the iOS system where the application bundle will be installed to**. From there it will have access to a limited scope of the file system and resources.

## Types of Deployments

There are two ways of deploying an application to an iOS device, and this is based on the signing configuration.

- **Development** -- Deploying an application to your devices
- **Distribution** -- Deploying an application to other people's devices

As a software developer, **to deploy an application to** one of your **iOS devices**, you **must have** a **private key** that is **paired with** an **identity certificate** that is **signed by Apple's Developer Certificate Authority**. An identity certificate that is signed by that CA will have permission to install on a limited number of specific devices, and then attach a debugger to that specific application to do development with it. This is a relatively elevated level of permissions on the system, and for this reason Apple enforces the limit of the number of devices registered to a single developer account.

The second kind of **deployment** is **for** the purpose of software **distribution**. Once an application has been fully developed and ready for use, it needs to be signed for distribution. This enables a level of permissions that is more locked down than the development style of deployment, and more in-line with apps that are acquired from the App Store or from Enterprise vendors. **Applications** that are **submitted to the App Store must be signed with a distribution identity certificate** first. This requires an additional Certificate Signing Request be made and submitted to Apple. However, this time it gets signed by a different CA, the Apple Distribution Certificate Authority. Additionally, **applications** that are **built for internal use are** likewise **signed with an Enterprise Distribution identity certificate**.

## More info: 
https://pewpewthespells.com/blog/migrating_code_signing.html
