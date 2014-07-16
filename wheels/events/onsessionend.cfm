<cffunction name="onSessionEnd" returntype="void" access="public" output="false">
	<cfargument name="sessionScope" type="any" required="true">
	<cfargument name="applicationScope" type="any" required="true">
	<cfscript>
		$simpleLock(execute="$runOnSessionEnd", executeArgs=arguments, name="wheelsReloadLock", type="readOnly", timeout=180);
	</cfscript>
</cffunction>

<cffunction name="$runOnSessionEnd" returntype="void" access="public" output="false">
	<cfargument name="sessionScope" type="any" required="true">
 	<cfargument name="applicationScope" type="any" required="true">
	<cfscript>
		$include(template="#arguments.applicationScope.wheels.eventPath#/onsessionend.cfm");
	</cfscript>
</cffunction>