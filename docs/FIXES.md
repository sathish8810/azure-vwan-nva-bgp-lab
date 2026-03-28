# Deployment Fixes Applied

## Fix 1 - Remove resWait DeploymentScript
- **Error**  : KeyBasedAuthenticationNotPermitted
- **Cause**  : Corp policy blocks Storage Account Key Auth
- **Fix**    : Removed resWait block lines 436-450

## Fix 2 - VPN Gateway SKU
- **Error**  : NonAzSkusNotAllowedForVPNGateway
- **Cause**  : VpnGw1 deprecated November 2025
- **Fix**    : Changed VpnGw1 to VpnGw1AZ + Generation2

## Fix 3 - BGP Hub Dependencies
- **Error**  : HubBgpConnectionParentHubMustHaveProvisionedRoutingState
- **Cause**  : BGP Connection created before Hub provisioned
- **Fix**    : Added resVpnGatewayHub1 and Hub2 to BGP dependsOn

## Fix 4 - BGP VPN Connection Dependencies
- **Error**  : HubBgpConnectionMustReferenceFullyProvisionedHubVirtualNetworkConnection
- **Cause**  : HubVnetConnection not ready when BGP connects
- **Fix**    : Added VpnConnection to BGP dependsOn

## Fix 5 - Public IP Zones
- **Error**  : VmssVpnGatewayPublicIpsMustHaveZonesConfigured
- **Cause**  : VpnGw1AZ requires zone-redundant Public IP
- **Fix**    : Added zones 1 2 3 to both PIPs
