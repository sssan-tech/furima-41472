function price() {
  const priceInput = document.getElementById('item-price');
  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById('add-tax-price');
    const addProfitDom = document.getElementById('profit');
    
    const taxValue = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = taxValue.toLocaleString();

    const profitValue = (inputValue - taxValue);
    addProfitDom.innerHTML = profitValue.toLocaleString();
  });
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);