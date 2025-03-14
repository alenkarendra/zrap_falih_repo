@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking BO projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZFLH_RAP_BOOKING_PV
  as projection on ZFLH_RAP_BOOKING as Booking
{
  key BookingUUID,
      TravelUUID,
      @Search.defaultSearchElement: true
      BookingID,
      BookingDate,
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID '} }]
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Search.defaultSearchElement: true
      CustomerID,
      _Customer.LastName as CustomerName,
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Carrier', element: 'AirlineID '} }]
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierID,
      _Carrier.Name as CarrierName,
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Flight', element: 'ConnectionID '},
                                           additionalBinding: [{ localElement: 'CarrierID', element: 'AirlineID' },
                                                               { localElement: 'FlightDate', element: 'FlightDate', usage: #RESULT },
                                                               { localElement: 'FlightPrice', element: 'Price', usage: #RESULT },
                                                               { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }] }]
      ConnectionID,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Currency', element: 'Currency'} }]
      CurrencyCode,
      CreatedBy,
      LastChangedBy,
      LocalLastChangedAt,
      
      /* Associations */
      _Travel : redirected to parent ZFLH_RAP_TRAVEL_PV,
      _Customer,
      _Carrier,
      _Flight
}
