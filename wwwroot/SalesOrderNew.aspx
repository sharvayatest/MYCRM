﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderNew.aspx.cs" Inherits="StarsProject.SalesOrderNew" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="app-assets/vendors/vendors.min.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/materialize.css" />
    <link rel="stylesheet" type="text/css" href="app-assets/css/themes/vertical-modern-menu-template/style.css" />

    <script type="text/javascript" src='<%=ResolveUrl("js/plugins/jquery-1.7.min.js") %>'></script>
    <script type="text/javascript" src="app-assets/js/vendors.min.js"></script>
    <script type="text/javascript" src="plugins/daterangepicker/moment.js"></script>

    <link rel="stylesheet" href="app-assets/vendors/select2/select2.min.css" type="text/css" />
    <link rel="stylesheet" href="app-assets/vendors/select2/select2-materialize.css" type="text/css" />
    <script src="app-assets/vendors/select2/select2.full.min.js"></script>
    <script src="app-assets/js/scripts/form-select2.js"></script>

    <link href="css/jquery.auto-complete.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.auto-complete.min.js"></script>

    <style type="text/css">
        table.responsive-table.striped.width-100 th {
            background-color: #6868d6 !important;
            color: white !important;
        }
        /* ==================================== */
        /*****         Modal Popup        *****/
        /* ==================================== */
        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 96%;
            height: 96%;
        }

        .btnTopRightCorner {
            display: block;
            box-sizing: border-box;
            width: 30px;
            height: 30px;
            border-width: 3px;
            border-style: solid;
            border-color: red;
            border-radius: 100%;
            background: -webkit-linear-gradient(-45deg, transparent 0%, transparent 46%, white 46%, white 56%,transparent 56%, transparent 100%), -webkit-linear-gradient(45deg, transparent 0%, transparent 46%, white 46%, white 56%,transparent 56%, transparent 100%);
            background-color: red;
            box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.5);
            transition: all 0.3s ease;
            position: relative;
            top: 12px;
            right: 15px;
        }
        /* ==================================== */
        /***** 19. STANDARD TABLES STYLES *****/
        /* ==================================== */
        .table input:not([type]), input[type=text]:not(.browser-default), input[type=password]:not(.browser-default),
        input[type=email]:not(.browser-default), input[type=url]:not(.browser-default), input[type=time]:not(.browser-default),
        input[type=date]:not(.browser-default), input[type=datetime]:not(.browser-default), input[type=datetime-local]:not(.browser-default),
        input[type=tel]:not(.browser-default), input[type=number]:not(.browser-default), input[type=search]:not(.browser-default), textarea.materialize-textarea {
            margin: 0px !important;
            height: 1.5rem !important;
            border-radius: 3px !important;
            font-size: 13px !important;
        }

        #tblQuotationDetail > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        #tblCharge > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        #tblSummary > tbody > tr > td {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        .limited {
            white-space: nowrap;
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>

    <script type="text/javascript">
        function pageLoad(sender, args) {
            $('tabs').tabs();
            $('.datepicker').datepicker({
                defaultDate: new Date((new Date()).getFullYear(), (new Date()).getMonth(), (new Date()).getDay()),
                format: "dd-mm-yyyy"
            });
            $('.timepicker').timepicker();
            $(".inputOther input:text").focus(function () { $(this).select(); });
            $(".inputOther input:text").click(function () { $(this).select(); });
            $('#menuDiscovery').click(function () { $('.tap-target').tapTarget('open'); });
            $('#txtOrderNo').focus();
            // --------------------------------------------------------
            $(function () {
                $(".tabs a").click(function () {
                    $("#hdnCurrTab").val($(this).attr("href").replace("#", ""));
                    retainTabPosition();
                });
            });
        }
        function retainTabPosition() {

            var currTab = $("#hdnCurrTab").val();

            $("#lnkProducts").removeClass("active");
            $("#lnkTNC").removeClass("active");
            $("#lnkPaySch").removeClass("active");
            $("#lnkShipment").removeClass("active");

            $("#pnl_Products").css("display", "none");
            $("#pnl_TNC").css("display", "none");
            $("#pnl_PaySch").css("display", "none");
            $("#pnl_Shipment").css("display", "none");

            if (currTab == 'pnl_Products') {
                $("#lnkProducts").addClass("active");
                $("#pnl_Products").css("display", "block");
            }
            else if (currTab == 'pnl_TNC') {
                $("#lnkTNC").addClass("active");
                $("#pnl_TNC").css("display", "block");
            }
            else if (currTab == 'pnl_PaySch') {
                $("#lnkPaySch").addClass("active");
                $("#pnl_PaySch").css("display", "block");
            }
            else if (currTab == 'pnl_Shipment') {
                $("#lnkShipment").addClass("active");
                $("#pnl_Shipment").css("display", "block");
            }
        }
        /*---------------------------------------------------------*/
        function showcaseError(xMsg) {
            M.toast({ html: '<ul id="ulToast" style="list-style:circle;">' + xMsg + '</ul>', displayLength: 4000 });
        }
        function showcaseError(xMsg, xClass) {
            M.toast({ html: '<ul id="ulToast">' + xMsg + '</ul>', classes: xClass, displayLength: 4000 });
        }
        function showcaseMessage(xText, xIcon) {
            xText = (xText == '') ? 'Action Performed !' : xText;
            xIcon = (xIcon == '') ? 'Info' : xIcon;
            swal({ title: "Message", text: xText, icon: xIcon });
        }

        function showErrorMessage(strMess) {
            jQuery.confirm({ title: 'Data Validation', content: 'Are you sure, You want to delete record !', type: 'red', typeAnimated: true });
        }
        /*---------------------------------------------------------*/
        function calcQuotation() {
            var q = parseFloat(jQuery("#txtQuantity").val() != '' ? jQuery("#txtQuantity").val() : 0);
            var ur = parseFloat(jQuery("#txtUnitRate").val() != '' ? jQuery("#txtUnitRate").val() : 0);
            var dp = parseFloat(jQuery("#txtDiscountPercent").val() != '' ? jQuery("#txtDiscountPercent").val() : 0);

            var nr = (ur - ((ur * dp) / 100)).toFixed(2);
            jQuery("#txtNetRate").val(nr);

            var a = (q * nr).toFixed(2);
            jQuery("#txtAmount").val(a);

            var tr = parseFloat(jQuery("#txtTaxRate").val() != '' ? jQuery("#txtTaxRate").val() : 0);
            ta = ((a * tr) / 100).toFixed(2);
            jQuery("#txtTaxAmount").val(ta);

            na = (parseFloat(a) + parseFloat(ta)).toFixed(2);
            jQuery("#txtNetAmount").val(na);
        }

        function openCustomerInfo(cat) {
            var keyid = (cat == 'view') ? jQuery('#hdnCustomerID').val() : "0";
            var pageUrl = (cat == 'view') ? "customers.aspx?mode=view&id=" + keyid : "customers.aspx?mode=view&id=0";
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }

        /*Add Product view on Product Name Vikram Rajput 15-07-2020*/
        function openProductInfo(cat) {
            var keyid = "0";
            var pageUrl = "Products.aspx?mode=view&id=0";
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
        }
        function openSpecification(pProdID) {
            var t11, t22;
            t11 = jQuery("#txtOrderNo").val();
            //if ($('input[type="radio"]:checked').val() == "Quotation")
            if ($('#rdblOption').val() == "Quotation")
                t22 = jQuery("#drpReferenceNo").val();
            else
                t22 = "";
            var pageUrl = "SalesOrderSpecification.aspx?OrderNo=" + t11 + "&FinishProductID=" + pProdID + "&QuotationNo=" + t22;
            $('#ifrModule').attr('src', pageUrl);
            $find("mpe").show();
            //$.colorbox({
            //    width: "98%", height: "98%", rel: 'cbQtSpec', inline: true, iframe: true, href: "SalesOrderSpecification.aspx?OrderNo=" + t11 + "&FinishProductID=" + pProdID + "&QuotationNo=" + t22,
            //    onClosed: function () { }
            //});
        }
    </script>

</head>
<body class="loginpage">
    <form id="frmEntry" runat="server">
        <asp:ScriptManager ID="srcUser" runat="server"></asp:ScriptManager>
        <div id="contentwrapper" class="contentwrapper">
            <asp:UpdatePanel ID="upUserPanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="widgetbox">
                        <%-- Bootstrap Quotation Modal Popup --%>
                        <div class="clearall"></div>
                        <asp:HiddenField ID="hdnpkID" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnSerialKey" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnProductUnitQty" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnCustomerID" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnMode" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnQuotationSpecification" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdnQuotationCurrency" runat="server" ClientIDMode="Static" Value="No" />
                        <asp:HiddenField ID="hdnCurrTab" runat="server" ClientIDMode="Static" EnableViewState="true" Value="pnl_Products" />
                        <asp:HiddenField ID="hdnApplicationIndustry" runat="server" ClientIDMode="Static" Value="" />
                        <asp:HiddenField ID="hdnSelectedReference" runat="server" ClientIDMode="Static" />
                        <div id="myModal" style="display: block; width: 100%;">
                            <div class="modal-content">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col m12">
                                            <div class="row">
                                                <div class="input-field col m2">
                                                    <label class="active" for="txtOrderNo">Order #</label>
                                                    <asp:TextBox ID="txtOrderNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="1" ReadOnly="true" placeholder="" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtOrderDate">Order Date <span class="materialize-red-text font-weight-800">*</span></label>
                                                    <asp:TextBox ID="txtOrderDate" runat="server" class="form-control" ClientIDMode="Static" TabIndex="2" placeholder="" TextMode="Date" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <asp:HiddenField ID="hdnCustStateID" runat="server" ClientIDMode="Static" />
                                                    <label class="active" for="txtCustomerName">
                                                        Customer Name 
                                                <%--<small class="text-muted font-italic">(Minimum 3 chars to activate search)</small>--%> 
                                                        <span class="materialize-red-text font-weight-800">*</span>
                                                        <a href="javascript:openCustomerInfo('view');">
                                                            <img src="images/registration.png" width="20" height="20" alt="Preview Customer Info" title="Preview Customer Info" style="display: inline-block; padding: 6px 0px 0px 0px;" />
                                                        </a>
                                                        <a href="javascript:openCustomerInfo('add');">
                                                            <img src="images/addCustomer.png" width="20" height="20" alt="Add New Customer" title="Add New Customer" style="display: inline-block; padding: 6px 0px 0px 0px;"/>
                                                        </a>
                                                    </label>
                                                    <asp:TextBox ID="txtCustomerName" runat="server" ClientIDMode="Static" class="form-control" onKeyup="bindDDLTo('#txtCustomerName')" AutoPostBack="true" OnTextChanged="txtCustomerName_TextChanged" TabIndex="3" placeholder="Minimum 3 chars to activate search" />
                                                </div>
                                                <div class="input-field col m3">
                                                    <label class="active" for="txtReference">Reference No.</label>
                                                    <asp:TextBox ID="txtReference" runat="server" class="form-control" ClientIDMode="Static" TabIndex="4" placeholder=""  MaxLength="20" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="rdblOption">Select Option</label>
                                                    <asp:DropDownList ID="rdblOption" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="rdblOption_SelectedIndexChanged" TabIndex="5">
                                                        <asp:ListItem Text="Inquiry" Value="Inquiry" />
                                                        <asp:ListItem Text="Quotation" Value="Quotation" />
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="input-field col m2">
                                                    <label class="active" runat="server" clientidmode="Static" id="lblReferenceType" for="drpReferenceNo">Quotation No</label>
                                                    <asp:DropDownList ID="drpReferenceNo" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="6" AutoPostBack="true" OnTextChanged="drpReferenceNo_TextChanged" />
                                                </div>
                                                <div id="divEmployee" runat="server" clientidmode="static" class="input-field col m2">
                                                    <label class="active" for="drpSalesPerson">Sales Executive</label>
                                                    <asp:DropDownList ID="drpSalesPerson" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="7">
                                                    </asp:DropDownList>
                                                </div>
                                                
                                                <% if (hdnQuotationCurrency.Value.ToLower() == "yes" || hdnQuotationCurrency.Value.ToLower() == "y")
                                                { %>
                                                <div class="input-field col m2">
                                                    <label class="active" for="drpCurrency">Select Currency</label>
                                                    <asp:DropDownList ID="drpCurrency" runat="server" class="select2-theme browser-default" data-placeholder="" EnableViewState="true" ClientIDMode="Static" TabIndex="8" />
                                                </div>
                                                <div class="input-field col m1.5">
                                                    <label class="active" for="txtExchangeRate">Exchange Rate</label>
                                                    <asp:TextBox ID="txtExchangeRate" runat="server" MaxLength="15" placeholder="" class="form-control" ClientIDMode="Static" TabIndex="9" />
                                                </div>
                                                <% } %>

                                                <div class="input-field col m2">
                                                    <label class="active" for="drpBank">Select Bank Details <span class="materialize-red-text font-weight-800">*</span></label>
                                                    <asp:DropDownList ID="drpBank" runat="server" class="select2-theme browser-default" placeholder="" EnableViewState="true" ClientIDMode="Static" TabIndex="10" />
                                                </div>
                                                <div class="input-field col m0" style="visibility:hidden">
                                                    <label class="active" for="drpApprovalStatus" style="margin-left: 15px;" >Approval Status</label>
                                                    <asp:DropDownList ID="drpApprovalStatus" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="11" disabled="true">
                                                        <asp:ListItem Text="Pending" Value="Pending" />
                                                        <asp:ListItem Text="On Hold" Value="On Hold" />
                                                        <asp:ListItem Text="Approved" Value="Approved" />
                                                        <asp:ListItem Text="Dispatched" Value="Dispatched" />
                                                        <asp:ListItem Text="Rejected" Value="Rejected" />
                                                    </asp:DropDownList>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col s12">
                                            <ul id="Ul1" class="tabs" runat="server" clientidmode="Static" enableviewstate="true" style="background-color: antiquewhite;">
                                                <li class="tab col m3 p-0"><a id="lnkProducts" class="left active" href="#pnl_Products">Product Detail</a></li>
                                                <li class="tab col m3 p-0"><a id="lnkTNC" class="left" href="#pnl_TNC">Terms & Coditions</a></li>
                                                <li class="tab col m3 p-0"><a id="lnkPaySch" class="left" href="#pnl_PaySch">Payment Schedule</a></li>
                                                <li class="tab col m3 p-0"><a id="lnkShipment" class="left" href="#pnl_Shipment">Shipment Detail</a></li>
                                            </ul>
                                        </div>
                                        <div id="pnl_Products" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: block;">
                                            <asp:Panel runat="server" ID="pnlDetail">
                                                <div class="row">
                                                    <table id="tblQuotationDetail" class="table responsive-table striped width-100">
                                                        <asp:Repeater ID="rptOrderDetail" runat="server" ClientIDMode="Static" OnItemCommand="rptOrderDetail_ItemCommand" OnItemDataBound="rptOrderDetail_ItemDataBound">
                                                            <HeaderTemplate>
                                                                <thead>
                                                                    <tr>
                                                                        <th class="left-align" style="width: 25%;">Product Name <span class="materialize-red-text font-weight-800">*</span>
                                                                            <a href="javascript:openProductInfo('add');">
                                                                                <img src="images/expand.png" width="30" height="20" style="padding: 5px 5px 0px 10px;" alt="Add New Product" title="Add New Product" tabindex="12" />
                                                                            </a>
                                                                        </th>
                                                                        <th class="center-align">Unit</th>
                                                                        <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                          { %>
                                                                        <th class="right-align">Unit Qty </th>
                                                                        <% } %>
                                                                        <th class="right-align" style="width: 8%;">Quantity <span class="materialize-red-text font-weight-800">*</span></th>
                                                                        <th class="center-align" style="width: 8%;">Unit Rate<span class="materialize-red-text font-weight-800">*</span></th>
                                                                        <th class="right-align">Disc. %</th>
                                                                        <th class="right-align">Disc.Amt</th>
                                                                        <th class="right-align">Net Rate</th>
                                                                        <th class="text-right">Header Disc</th>
                                                                        <th class="center-align" style="width: 10%;">Amount</th>
                                                                        <th class="right-align" style="width: 8%;padding: 0px 13px 0px 0px;">Tax %</th>
                                                                        <th class="center-align" style="width: 10%;">Tax Amount</th>
                                                                        <th class="center-align" style="width: 10%;">Net Amount</th>
                                                                        <th class="center-align" style="width: 10%;">Delivery Date</th>
                                                                        <% if (hdnQuotationSpecification.Value.ToLower() == "yes")
                                                                           { %>
                                                                        <th class="center-align" style="width: 10%;">Specs</th>
                                                                        <% } %>
                                                                        <th class="center-align" style="width: 10%;">Delete</th>
                                                                    </tr>
                                                                </thead>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td class="left-align" style="width: 25%;">
                                                                        <%# Eval("ProductNameLong") %>
                                                                        <asp:HiddenField ID="edProductID" runat="server" ClientIDMode="Static" Value='<%# Eval("ProductID") %>' />
                                                                        <asp:HiddenField ID="edProductName" runat="server" ClientIDMode="Static" Value='<%# Eval("ProductName") %>' />
                                                                        <asp:HiddenField ID="edTaxType" runat="server" ClientIDMode="Static" Value='<%# Eval("TaxType") %>' />
                                                                        <asp:HiddenField ID="edBox_SQFT" runat="server" ClientIDMode="Static" Value='<%# Eval("Box_SQFT") %>' />
                                                                        <asp:HiddenField ID="edBox_SQMT" runat="server" ClientIDMode="Static" Value='<%# Eval("Box_SQMT") %>' />
                                                                        <asp:HiddenField ID="edUnitQuantity" runat="server" ClientIDMode="Static" Value='<%# Eval("UnitQuantity") %>' />
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <asp:TextBox ID="edUnit" MaxLength="15" runat="server" ClientIDMode="Static" Text='<%# Eval("Unit") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="13" />
                                                                    </td>
                                                                    <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                        { %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edUnitQty" runat="server" ClientIDMode="Static" Text='<%# Eval("UnitQty") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="14" />
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edQuantity" runat="server" ClientIDMode="Static" Text='<%# Eval("Quantity") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="15" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="edUnitRate" runat="server" ClientIDMode="Static" Text='<%# Eval("UnitRate") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 70px; text-align: right;" TabIndex="16" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="edDiscountPercent" runat="server" ClientIDMode="Static" Text='<%# Eval("DiscountPercent") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 50px; text-align: right;" TabIndex="17" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="edDiscountAmt" runat="server" ClientIDMode="Static" Text='<%# Eval("DiscountAmt") %>' OnTextChanged="editItem_TextChanged" Style="width: 80px; text-align: right;" Enabled="false" TabIndex="18" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="edNetRate" runat="server" ClientIDMode="Static" Text='<%# Eval("NetRate") %>' Style="width: 80px; text-align: right;" Enabled="false" TabIndex="19" />
                                                                    </td>
                                                                    <td class="text-right">
                                                                        <asp:TextBox ID="edHeaderDiscAmt" runat="server" ClientIDMode="Static" Text='<%# Eval("HeaderDiscAmt") %>' Style="width: 80px; text-align: right;" Enabled="false" TabIndex="20" CssClass="form-control" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="edAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("Amount") %>' Style="width: 90px; text-align: right;" Enabled="false" TabIndex="21" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:HiddenField ID="edhdnCGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("CGSTPer") %>' />
                                                                        <asp:HiddenField ID="edhdnSGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("SGSTPer") %>' />
                                                                        <asp:HiddenField ID="edhdnIGSTPer" runat="server" ClientIDMode="Static" Value='<%# Eval("IGSTPer") %>' />
                                                                        <asp:TextBox ID="edTaxRate" runat="server" ClientIDMode="Static" Text='<%# Eval("TaxRate") %>' AutoPostBack="true" OnTextChanged="editItem_TextChanged" Style="width: 50px; text-align: right;" TabIndex="22" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:HiddenField ID="edhdnCGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("CGSTAmt") %>' />
                                                                        <asp:HiddenField ID="edhdnSGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("SGSTAmt") %>' />
                                                                        <asp:HiddenField ID="edhdnIGSTAmt" runat="server" ClientIDMode="Static" Value='<%# Eval("IGSTAmt") %>' />
                                                                        <asp:TextBox ID="edTaxAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("TaxAmount") %>' AutoPostBack="true" Style="width: 90px; text-align: right;" Enabled="false" TabIndex="23" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="edNetAmount" runat="server" ClientIDMode="Static" Text='<%# Eval("NetAmount") %>' AutoPostBack="true" Style="width: 90px; text-align: right;" Enabled="false" TabIndex="24" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="edDelDate" runat="server" ClientIDMode="Static" Text='<%# Eval("DeliveryDate","{0:yyyy-MM-dd}") %>' AutoPostBack="true" Style="width: 130px; text-align: right;" TabIndex="25" placeholder="" TextMode="Date" OnTextChanged="editItem_TextChanged" />
                                                                    </td>
                                                                    <% if (hdnQuotationSpecification.Value.ToLower() == "yes")
                                                                       { %>
                                                                    <td class="center-align" style="width: 10%;">
                                                                        <a id="lnkSpecs" href="javascript:openSpecification('<%# Eval("ProductID") %>');" tabindex="24"><small>Specs</small></a>
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="center-align" style="width: 10%;">
                                                                        <asp:ImageButton ID="ImgbtnDelete" runat="server" ClientIDMode="Static" ImageUrl="~/images/delete.png" ToolTip="Delete" CommandName="Delete" CommandArgument='<%# Eval("pkID") %>' Width="20" Height="20" TabIndex="26" />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                <tr style="background-color: #dde8f3; border-bottom: 5px solid navy;">
                                                                    <td class="left-align" style="width: 25%;">
                                                                        <asp:HiddenField ID="hdnProductID" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnTaxType" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnOrgUnitRate" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnBox_SQFT" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnBox_SQMT" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnUnitQuantity" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtProductName" runat="server" ClientIDMode="Static" class="form-control" onKeyup="bindDDLProductTo('#txtProductName')" AutoPostBack="true" OnTextChanged="txtProductName_TextChanged" Width="100%" TabIndex="21" />
                                                                    </td>
                                                                    <td class="center-align">
                                                                        <asp:TextBox ID="txtUnit" runat="server" ClientIDMode="Static" Width="50" TabIndex="22" AutoPostBack="true" OnTextChanged="txtUnit_TextChanged" />
                                                                    </td>
                                                                    <% if (hdnSerialKey.Value == "SA98-6HY9-HU67-LORF")
                                                                        { %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox  ID="txtUnitQty" runat="server" ClientIDMode="Static" Width="70" AutoPostBack="true" OnTextChanged="txtUnitQty_TextChanged" TabIndex="23" />
                                                                    </td>
                                                                    <% } %>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="txtQuantity" runat="server" ClientIDMode="Static" Width="70" TabIndex="24" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:TextBox ID="txtUnitRate" runat="server" ClientIDMode="Static" Width="80" TabIndex="25" AutoPostBack="true" OnTextChanged="txtUnitRate_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="txtDiscountPercent" runat="server" ClientIDMode="Static" Width="50" TabIndex="26" AutoPostBack="true" OnTextChanged="txtDiscountPercent_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align ">
                                                                        <asp:TextBox ID="txtDiscountAmt" runat="server" ClientIDMode="Static" Width="80" TabIndex="27" Enabled="true" />
                                                                    </td>
                                                                    <td class="right-align">
                                                                        <asp:TextBox ID="txtNetRate" runat="server" ClientIDMode="Static" Width="80" TabIndex="28" Enabled="true" />
                                                                    </td>
                                                                    <td class="text-right">
                                                                        <asp:TextBox ID="txtHeaderDiscAmt" runat="server" ClientIDMode="Static" Width="80" TabIndex="29" Enabled="false" CssClass="form-control" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="txtAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="30" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 8%;">
                                                                        <asp:HiddenField ID="hdnCGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnSGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnIGSTPer" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtTaxRate" runat="server" ClientIDMode="Static" Width="50" TabIndex="31" AutoPostBack="true" OnTextChanged="txtTaxRate_TextChanged" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:HiddenField ID="hdnCGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnSGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:HiddenField ID="hdnIGSTAmt" runat="server" ClientIDMode="Static" />
                                                                        <asp:TextBox ID="txtTaxAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="32" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="txtNetAmount" runat="server" ClientIDMode="Static" Width="90" TabIndex="33" Enabled="false" />
                                                                    </td>
                                                                    <td class="right-align" style="width: 10%;">
                                                                        <asp:TextBox ID="txtDelDate" runat="server" ClientIDMode="Static" Width="130" TabIndex="34" Enabled="true" TextMode="Date" />
                                                                    </td>
                                                                    <td class="center-align" colspan="2" style="width: 20%;">
                                                                        <asp:ImageButton ID="imgBtnSave" runat="server" ImageUrl="~/images/buttons/bt-add2.png" ToolTip="Add Item" CommandName="Save" CommandArgument='0' Width="110" Height="30" TabIndex="35" />
                                                                    </td>
                                                                </tr>
                                                                <tr class="hide" style="background-color: navy; min-height: 50px;">
                                                                    <td class="text-right" colspan="5" style="color: White; font-size: 16px;">Grand Total: </td>
                                                                    <td class="text-right" style="display: none;">
                                                                        <asp:Label ID="lblTotalDiscAmt" runat="server" ClientIDMode="Static" Width="100" TabIndex="36" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right" style="color: White; font-size: 16px;"></td>
                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalAmt" runat="server" ClientIDMode="Static" Width="100" TabIndex="37" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right" style="color: White; font-size: 16px;"></td>

                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalTaxAmount" runat="server" ClientIDMode="Static" Width="100" TabIndex="38" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td class="text-right">
                                                                        <asp:Label ID="lblTotalNetAmount" runat="server" ClientIDMode="Static" Width="100" TabIndex="39" Enabled="false" Style="color: White; font-size: 16px;" />
                                                                    </td>
                                                                    <td colspan="2"></td>
                                                                </tr>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </table>
                                                </div>
                                            </asp:Panel>
                                            <div class="row mt-1">
                                                <div class="col m3">
                                                    <asp:HiddenField ID="hdnOthChrgGST1" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic1" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST2" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic2" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST3" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic3" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST4" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic4" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgGST5" runat="server" ClientIDMode="Static" />
                                                    <asp:HiddenField ID="hdnOthChrgBasic5" runat="server" ClientIDMode="Static" />
                                                    <table id="tblCharge" class="table responsive-table striped width-100" cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tbody>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg1" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="40" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg1_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt1" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="41" AutoPostBack="true" OnTextChanged="txtOthChrgAmt1_TextChanged" Style="text-align: right;" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg2" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="42" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg2_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt2" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="43" AutoPostBack="true" OnTextChanged="txtOthChrgAmt2_TextChanged" Style="text-align: right;" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg3" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="44" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg3_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt3" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="45" AutoPostBack="true" OnTextChanged="txtOthChrgAmt3_TextChanged" Style="text-align: right;" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg4" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="46" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg4_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt4" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="47" AutoPostBack="true" OnTextChanged="txtOthChrgAmt4_TextChanged" Style="text-align: right;" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="width-70">
                                                                    <asp:DropDownList ID="drpOthChrg5" runat="server" class="select2-theme browser-default" EnableViewState="true" ClientIDMode="Static" TabIndex="48" AutoPostBack="true" OnSelectedIndexChanged="drpOthChrg5_SelectedIndexChanged" />
                                                                </td>
                                                                <td class="width-30">
                                                                    <asp:TextBox ID="txtOthChrgAmt5" class="form-control inputOther" runat="server" ClientIDMode="Static" TabIndex="49" AutoPostBack="true" OnTextChanged="txtOthChrgAmt5_TextChanged" Style="text-align: right;" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="col m9">
                                                    <table id="tblSummary" class="table responsive-table striped" border="0">
                                                        <tbody>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Discount Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtHeadDiscount" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="50" AutoPostBack="true" OnTextChanged="txtHeadDiscount_TextChanged" />
                                                                </td>
                                                            </tr>

                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Basic Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotBasicAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="51" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Other Charge <small style="color: navy; font-weight: 600;">(With Tax)</small></td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotOthChrgBeforeGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="52" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <asp:HiddenField ID="hdnTotCGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <asp:HiddenField ID="hdnTotSGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <asp:HiddenField ID="hdnTotIGSTAmt" runat="server" ClientIDMode="Static" />
                                                                <td class="width-80 right-align">Total GST</td>
                                                                <td class="width-20">
                                                                    <asp:HiddenField ID="hdnTotItemGST" runat="server" ClientIDMode="Static" />
                                                                    <asp:TextBox ID="txtTotGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="53" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Other Charges <small style="color: Navy; font-weight: 600;">(Excluding Tax)</small></td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotOthChrgAfterGST" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="54" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Round Off</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtRoff" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="55" ReadOnly="true" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-80 right-align">Net Amount</td>
                                                                <td class="width-20">
                                                                    <asp:TextBox ID="txtTotNetAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="56" ReadOnly="true" Style="font-weight: bold;" />
                                                                </td>
                                                            </tr>
                                                            <tr class="border-none">
                                                                <td class="width-70 right-align">Adv.%</td>
                                                                <td class="width-30">
                                                                    <table class="table responsive-table striped">
                                                                        <tbody>
                                                                            <tr>
                                                                                <td><asp:TextBox ID="txtAdvPer" class="form-control" runat="server" ClientIDMode="Static" TabIndex="57" Style="font-weight: bold; width:50px;" ToolTip="Advance Percentage" placeholder="" AutoPostBack="true" OnTextChanged="txtAdvPer_TextChanged" /></td>
                                                                                <td><span>Amt</span></td>
                                                                                <td><asp:TextBox ID="txtAdvAmt" class="form-control inputCalc" runat="server" ClientIDMode="Static" TabIndex="58" Style="font-weight: bold;width:80px;" ToolTip="Advance Amount" /></td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="pnl_TNC" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtExchangeRate">Select Terms & Conditions</label>
                                                    <asp:DropDownList ID="drpTNC" runat="server" ClientIDMode="Static" class="select2-theme browser-default" EnableViewState="true" TabIndex="59" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="drpTNC_SelectedIndexChanged" />
                                                </div>
                                                <div class="input-field col m12">
                                                    <label class="active" for="txtTermsCondition">Terms & Condition</label>
                                                    <asp:TextBox ID="txtTermsCondition" runat="server" class="form-control" ClientIDMode="Static" TabIndex="60" TextMode="MultiLine" Rows="20" Height="100px" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m6">
                                                    <label class="active" for="txtDelTerms">Delivery Terms</label>
                                                    <asp:TextBox ID="txtDelTerms" runat="server" class="form-control" ClientIDMode="Static" TabIndex="61" TextMode="SingleLine" Rows="20" placeholder="" />
                                                </div>
                                                <div class="input-field col m6">
                                                    <label class="active" for="txtPayTerms">Payment Terms</label>
                                                    <asp:TextBox ID="txtPayTerms" runat="server" class="form-control" ClientIDMode="Static" TabIndex="62" TextMode="SingleLine" Rows="20" placeholder="" />
                                                </div>
                                            </div>
                                            
                                        </div>

                                        <div id="pnl_PaySch" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <table id="tblPaySchedule" class="table responsive-table striped">
                                                <asp:Repeater ID="rptPaySchedule" runat="server" ClientIDMode="Static" OnItemCommand="rptPaySchedule_ItemCommand">
                                                    <HeaderTemplate>
                                                        <thead>
                                                            <tr>
                                                                <th class="right-align width-30">Amount</th>
                                                                <th class="center-align width-30">Due Date</th>
                                                                <th class="center-align width-40">Action</th>
                                                            </tr>
                                                        </thead>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="right-align width-30">
                                                                <asp:TextBox ID="edPayAmount" runat="server" ClientIDMode="Static" CssClass="form-control text-right" Text='<%# Eval("PayAmount") %>' AutoPostBack="true" TabIndex="63" />
                                                            </td>
                                                            <td class="center-align width-30">
                                                                <asp:TextBox ID="edDueDate" runat="server" ClientIDMode="Static" CssClass="datepicker" Text='<%# Eval("DueDate", "{0:yyyy-MM-dd}") %>' AutoPostBack="true" Width="180px" TabIndex="64" />
                                                            </td>
                                                            <td class="center-align width-40">
                                                                <asp:ImageButton ID="ImgbtnEdit11" runat="server" ClientIDMode="Static" ImageUrl="~/images/savedata.png" ToolTip="Update" CommandName="updpayment" CommandArgument='<%# Eval("pkID") %>' Width="40" Height="20" TabIndex="65" Visible="false" />
                                                                <asp:ImageButton ID="ImgbtnDelete11" runat="server" ClientIDMode="Static" ImageUrl="~/images/delete.png" ToolTip="Delete" CommandName="delpayment" CommandArgument='<%# Eval("pkID") %>' Width="20" Height="20" />
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <tr>
                                                            <td class="right-align width-30">
                                                                <asp:TextBox ID="ftPayAmount" runat="server" ClientIDMode="Static" CssClass="form-control text-right" Text='<%# Eval("PayAmount") %>' AutoPostBack="true" TabIndex="66" />
                                                            </td>
                                                            <td class="center-align width-30">
                                                                <asp:TextBox ID="ftDueDate" runat="server" ClientIDMode="Static" Class="form-control" Text='<%# Eval("DueDate", "{0:yyyy-MM-dd}") %>' AutoPostBack="true" Width="180px" TabIndex="67" TextMode="Date" />
                                                            </td>
                                                            <td class="center-align width-40">
                                                                <asp:ImageButton ID="ImgbtnAddSch" runat="server" ClientIDMode="Static" ImageUrl="~/images/expand.png" ToolTip="Add Schedule" CommandName="addpayment" CommandArgument='<%# Eval("pkID") %>' Width="30" Height="30" TabIndex="68" />
                                                            </td>
                                                        </tr>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </table>
                                        </div>

                                        <div id="pnl_Shipment" class="col m12 mt-1" runat="server" clientidmode="Static" enableviewstate="true" style="display: none;">
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPreCarrBy">Pre Carriage By (Transporter Name)</label>
                                                    <asp:TextBox ID="txtPreCarrBy" runat="server" class="form-control" ClientIDMode="Static" TabIndex="69" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPreCarrRecPlace">Place Of Rec.By Pre Carrier</label>
                                                    <asp:TextBox ID="txtPreCarrRecPlace" runat="server" class="form-control" ClientIDMode="Static" TabIndex="70" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtFlightNo">Vessel/Flight No</label>
                                                    <asp:TextBox ID="txtFlightNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="71" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfLoading">Port Of Loading</label>
                                                    <asp:TextBox ID="txtPortOfLoading" runat="server" class="form-control" ClientIDMode="Static" TabIndex="72" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfDispatch">Port Of Dispatch</label>
                                                    <asp:TextBox ID="txtPortOfDispatch" runat="server" class="form-control" ClientIDMode="Static" TabIndex="73" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPortOfDestination">Port Of Destination</label>
                                                    <asp:TextBox ID="txtPortOfDestination" runat="server" class="form-control" ClientIDMode="Static" TabIndex="74" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtContainerNo">Container No.</label>
                                                    <asp:TextBox ID="txtContainerNo" runat="server" class="form-control" ClientIDMode="Static" TabIndex="75" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPackages">Packages</label>
                                                    <asp:TextBox ID="txtPackages" runat="server" class="form-control" ClientIDMode="Static" TabIndex="76" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtPackageType">Type Of Package</label>
                                                    <asp:TextBox ID="txtPackageType" runat="server" class="form-control" ClientIDMode="Static" TabIndex="77" placeholder="" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtNetWeight">Net Weight(KGs)</label>
                                                    <asp:TextBox ID="txtNetWeight" runat="server" class="form-control" ClientIDMode="Static" TabIndex="78" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtGrossWeight">Gross Weight(KGs)</label>
                                                    <asp:TextBox ID="txtGrossWeight" runat="server" class="form-control" ClientIDMode="Static" TabIndex="79" placeholder="" />
                                                </div>
                                                <div class="input-field col m4">
                                                    <label class="active" for="txtFOB">FOB (Free Of Board)</label>
                                                    <asp:TextBox ID="txtFOB" runat="server" class="form-control" ClientIDMode="Static" TabIndex="80" placeholder="" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row padding-1 gradient-45deg-blue-grey-blue-grey vertical-align-bottom" style="margin-top: 10px;">
                                    <div class="col m12">
                                        <button type="button" id="btnReset" runat="server" clientidmode="Static" class="btn orange left" onserverclick="btnReset_Click" tabindex="73"><i class="material-icons left">backspace</i>Clear & Add New</button>
                                        <button type="button" id="btnSaveEmail" runat="server" clientidmode="Static" class="btn cyan  right mr-1" onserverclick="btnSaveEmail_Click" tabindex="82"><i class="material-icons left">email</i>Save - Send Email</button>
                                        <button type="button" id="btnSave" runat="server" clientidmode="Static" class="btn cyan right mr-1" onserverclick="btnSave_Click" tabindex="81"><i class="material-icons left">save</i>Save</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <%-- PopUp Modal Box to Open Window --%>
                    <asp:Button ID="Button1" CssClass="hide" runat="server" Text="Fill Form in Popup" />
                    <cc1:ModalPopupExtender ID="myModalPopup" BehaviorID="mpe" runat="server" ClientIDMode="Static" PopupControlID="Panl1" TargetControlID="Button1" CancelControlID="Button2" BackgroundCssClass="Background">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none; border-radius: 10px; padding-right: 10px !important;">
                        <div id="myModal123">
                            <div class="modal-header position-sticky gradient-45deg-light-blue-indigo m-0" style="margin-bottom: 10px !important;">
                                <h5 class=" z-depth-5" style="font-size: 2rem !important; font-weight: 800; line-height: 50px; margin: 0; text-align: left; padding-left: 15px;">
                                    <i class="material-icons prefix">ac_unit</i>
                                    <span id="spnModuleHeader" runat="server" clientidmode="static">Manage Module</span>
                                    <asp:Button CssClass="btnTopRightCorner float-right" ID="Button2" runat="server" Text="" />
                                </h5>
                            </div>
                        </div>
                        <iframe id="ifrModule" src="about:blank" runat="server" clientidmode="static" scrolling="auto" style="border: 1px solid silver; background-color: transparent; width: 100%; height: 90%; padding: 5px;"></iframe>
                        <br />
                    </asp:Panel>

                    <script type="text/javascript">
                        $("input").keypress(function (event) {
                            if (event.which == 13) {
                                event.preventDefault();
                                //$("form").submit();
                            }
                        });

                        function bindDDLTo(selector) {
                            if ($(selector).val().length >= 1) {
                                jQuery.ajax({
                                    type: "POST",
                                    url: "InquiryInfo.aspx/FilterCustomerByModule",
                                    data: '{pCustName:\'' + $(selector).val() + '\', pSearchModule:\'CustomerSearchSales\'}',
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {
                                        console.log(data);
                                        var sample = JSON.parse(data.d);
                                        $(selector).autoComplete({
                                            minChars: 1,
                                            source: function (term, suggest) {
                                                term = term.toLowerCase();
                                                var choices = sample;
                                                suggest(choices);
                                            },
                                            renderItem: function (item, search) {
                                                $(".autocomplete-suggestion").remove();
                                                //search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
                                                //var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
                                                return '<div class="autocomplete-suggestion" data-langname="' + item.CustomerID + '" data-lang="' + item.CustomerName + '" data-val="' + search + '">' + item.CustomerName + '</div>';
                                            },
                                            onSelect: function (e, term, item) {
                                                //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                                                $(selector).val(item.html());
                                                $("#hdnCustomerID").val(item.data('langname'));
                                                $("#drpQuotation").focus();
                                            }
                                        });
                                    },
                                    error: function (r) { alert('Error : ' + r.responseText); },
                                    failure: function (r) { alert('failure'); }
                                });
                            }
                            else {
                                if ($(selector).val().length == 0) {
                                    $("#hdnCustomerID").val('');
                                }
                            }
                        }

                        function bindDDLProductTo(selector) {
                            if ($(selector).val().length >= 1) {
                                jQuery.ajax({
                                    type: "POST",
                                    url: "InquiryInfo.aspx/FilterProduct",
                                    data: '{pProductName:\'' + $(selector).val() + '\', pSearchModule:\'ProductSearchTypeSalesOrder\'}',
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {
                                        var sample = JSON.parse(data.d);
                                        $(selector).autoComplete({
                                            minChars: 1,
                                            source: function (term, suggest) {
                                                term = term.toLowerCase();
                                                var choices = sample;
                                                suggest(choices);
                                            },
                                            renderItem: function (item, search) {
                                                $(".autocomplete-suggestion").remove();
                                                return '<div class="autocomplete-suggestion" data-langname="' + item.pkID + '" data-lang="' + item.ProductNameLong + '" data-val="' + search + '">' + item.ProductNameLongStk + '</div>';
                                            },
                                            onSelect: function (e, term, item) {
                                                //console.log('Item "' + item.data('langname') + ' (' + item.data('lang') + ')" selected by ' + (e.type == 'keydown' ? 'pressing enter or tab' : 'mouse click') + '.');
                                                $(selector).val(item.data('lang'));
                                                $("#hdnProductID").val(item.data('langname'));
                                                $("#txtReferenceName").focus();
                                            }
                                        });

                                    },
                                    error: function (r) { alert('Error : ' + r.responseText); },
                                    failure: function (r) { alert('failure'); }
                                });
                                return false;
                            }
                            else {
                                if ($(selector).val().length == 0) {
                                    $("#hdnProductID").val('');
                                }
                            }
                        }
                        function clearProductField() {
                            $("#hdnProductID").val('');
                            $("#txtProductName").val('');
                            $("#txtQuantity").val('');
                            $("#txtUnit").val('');
                            $("#txtUnitRate").val('');
                            $("#txtDiscountPercent").val('');
                            $("#txtNetRate").val('');
                            $("#txtAmount").val('');
                            $("#txtTaxRate").val('');
                            $("#txtTaxAmount").val('');
                            $("#txtNetAmount").val('');
                            $("#txtProductName").focus();
                        }
                        $('#btnReset').focusout(function () {
                            $('#txtOrderNo').focus();
                        });

                    </script>
                </ContentTemplate>
<%--                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID ="txtHeadDiscount" EventName="TextChanged" />
                </Triggers>--%>

            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>

