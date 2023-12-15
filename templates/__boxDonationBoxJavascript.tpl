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
				element.classList.toggle('donationBoxThanksVisible','hidden');
			});
			document.querySelector('#donationBoxCloseButton').addEventListener('click', (event) => {
				var element = document.getElementById("donationBoxThanks");
				element.classList.remove("donationBoxThanksVisible");
				event.preventDefault();
			});	
		}
	}
	document.getElementById('donationRange').oninput = donation;
	donation();
})();
</script>