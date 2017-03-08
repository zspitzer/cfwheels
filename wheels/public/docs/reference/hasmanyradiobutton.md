```coldfusion
hasManyRadioButton(objectName, association, property, keys, tagValue [, checkIfBlank, label ])
```
```coldfusion
// Show radio buttons for associating a default address with the current author 
<cfloop query="addresses">
    #hasManyRadioButton(
        label=addresses.title,
        objectName="author",
        association="authorsDefaultAddresses",
        keys="#author.key()#,#addresses.id#"
    )#
</cfloop>
```