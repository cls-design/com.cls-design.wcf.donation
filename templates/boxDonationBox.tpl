<div class="donationBox">
	<div id="donationBoxThanks" class="hidden">
		<div>
			<div>
				<div>{lang}wcf.donation.thanks.message{/lang}</div>
				<a id="donationBoxCloseButton" class="jsTooltip" title="{lang}wcf.donation.button.closePopup{/lang}"></a>
			</div>
		</div>
	</div>

	{if USER_DONATION_TEXT}
	<div class="donationText">
		{if USER_DONATION_TEXT_ENABLE_HTML}{@USER_DONATION_TEXT|phrase}{else}{@USER_DONATION_TEXT|phrase|newlineToBreak}{/if}
	</div>
	{/if}

	<div class="donationBar">
		<div class="donationBarSelection">
			<div id="donationTitle">
				<div>
					<h3>{if USER_DONATION_USE_OWN_OBJECT}{@USER_DONATION_OWN_OBJECT|language}{else}{lang}wcf.acp.option.user_donation_type_{@USER_DONATION_TYPE}{/lang}{/if} {lang}wcf.donation.donation{/lang}</h3>
					<div id="donationSum"></div>
				</div>
				<div>
					<img src="{@$__wcf->getPath()}/images/donation/{if USER_DONATION_USE_OWN_OBJECT}{@USER_DONATION_OWN_ICON}{else}{@USER_DONATION_TYPE}.png{/if}" style="width: 64px; height: 64px;">
					<div id="donationSelection"></div>
				</div>
			</div>
		</div>
		<input id="donationRange" type="range" min="1" max="{@USER_DONATION_MAX_DONATION}" value="1" step="1" />
	</div>

	{if USER_DONATION_TRANSFER_ACTIVATE == 1 && $__wcf->user->userID}
	<button id="donationTransferLink" class="button buttonPrimary jsStaticDialog" data-dialog-id="donationNoteOverlay">{lang}wcf.donation.donation_transfer{/lang}</button>
	{/if}
	
	{if USER_DONATION_PAYPAL_LINK}
	<a id="donationPaypayLink" class="button buttonPrimary noDereferer" {if USER_DONATION_NEW_WINDOW == 1}target="_blank"{/if}>{lang}wcf.donation.link{/lang}</a>
	<p><small>{lang}wcf.donation.link.description{/lang}</small></p>
	{/if}
	
	{if USER_DONATION_TRANSFER_ACTIVATE == 1 && $__wcf->user->userID}
	<div id="donationNoteOverlay" class="jsStaticDialogContent" data-title="{lang}wcf.donation.title{/lang}">
		<div id="donationNoteOverlayContent">
			<dl>
				<dt>{lang}wcf.donation.donation_transfer_name{/lang}</dt>
				<dd><input value="{USER_DONATION_TRANSFER_NAME}" onclick="this.select()" readonly="readonly" type="text" style="width: 100%"></dd>
			</dl>
			<dl>
				<dt>{lang}wcf.donation.donation_transfer_iban{/lang}</dt>
				<dd><input value="{USER_DONATION_TRANSFER_IBAN}" onclick="this.select()" readonly="readonly" type="text" style="width: 100%"></dd>
			</dl>
			<dl>
				<dt>{lang}wcf.donation.donation_transfer_bic{/lang}</dt>
				<dd><input value="{USER_DONATION_TRANSFER_BIC}" onclick="this.select()" readonly="readonly" type="text" style="width: 100%"></dd>
			</dl>
			<dl>
				<dt>{lang}wcf.donation.donation_transfer_amount{/lang}</dt>
				<dd><div id="donationSumTransfer"></div></dd>
			</dl>
		 	<p style="margin-top: 20px;">{lang}wcf.donation.donation_transfer_note{/lang}</p>
		</div>
	</div>
	{/if}
	
	{if USER_DONATION_GOAL != 0}
	<div class="donationGoalProgress">
		<h3>{lang}wcf.donation.donation_goal{/lang}</h3>
		<progress min="0" max="100" value="{@USER_DONATION_GOAL}"></progress>
		<p><small>{lang}wcf.donation.donation_goal_progress{/lang}</small></p>	
	</div>
	{/if}

	<script>
	(function () {
		function donation(){
			var donationFactor = {@USER_DONATION_FACTOR};
			var donationNumberFormat = '{if $__wcf->getLanguage()->languageCode=='de'}de-DE{else}en-US{/if}';
			var donationCurrency = '{if $__wcf->getLanguage()->languageCode=='de'}EUR{else}USD{/if}';
			var donationTransfer = 	{if USER_DONATION_TRANSFER_ACTIVATE == 1 && $__wcf->user->userID}true{else}false{/if};
			var donationPaypal = 	{if USER_DONATION_PAYPAL_LINK}true{else}false{/if};
			var donationPaypalLinkBlank = '{@USER_DONATION_PAYPAL_LINK}';
			  
			let donationInput = document.getElementById('donationRange');
			var donation = Number.parseFloat(donationInput.value);
			var donationBarWidth = Number.parseFloat((donation - donationInput.min) / (donationInput.max - donationInput.min) * 100).toFixed(0);
			var donationFormatter = new Intl.NumberFormat(donationNumberFormat, {
				style: 'currency',
				currency: donationCurrency,
				minimumFractionDigits: 2,
				maximumFractionDigits: 2,
			});
			donationInput.style.background = 'linear-gradient(to right, #0065B1 0%, #0065B1 ' + donationBarWidth + '%, #45abf8 ' + donationBarWidth + '%, #45abf8 100%)';
			document.getElementById('donationSelection').innerHTML = donation;
			document.getElementById('donationSum').innerHTML = donationFormatter.format(donationInput.value * donationFactor);
			
			if(donationTransfer === true){
				document.getElementById('donationSumTransfer').innerHTML = donationFormatter.format(donationInput.value * donationFactor);
			}
			// Paypal
			if(donationPaypal === true){
				var donationPaypalValue = document.getElementById("donationRange").value;
				var donationPaypalLink = donationPaypalLinkBlank + (donationPaypalValue * donationFactor).toFixed(2);
				document.getElementById('donationPaypayLink').setAttribute("href",donationPaypalLink);
				document.querySelector('#donationPaypayLink').addEventListener('click', () => {
					var element = document.getElementById("donationBoxThanks");
					element.classList.toggle("donationBoxThanksVisible");
				});
				document.querySelector('#donationBoxCloseButton').addEventListener('click', () => {
					var element = document.getElementById("donationBoxThanks");
					element.classList.toggle("donationBoxThanksVisible");
				});	
			}
		}
		document.getElementById('donationRange').oninput = donation;
		donation();
	})();
	</script>
</div>