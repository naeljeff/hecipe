const inputGroup = document.getElementsByClassName("quantity-input");
const itemSubTotal = document.getElementsByClassName("item-subtotal");
const total = document.getElementById("total-price-text");

const calculateTotal = () => {
  let totalPrice = 0;
  for (let i = 0; i < inputGroup.length; i++) {
    const input = inputGroup[i].firstElementChild;
    const saveBtn = inputGroup[i].lastElementChild;
    const itemPrice = itemSubTotal[i].previousElementSibling.innerHTML;

    totalPrice += itemPrice * input.value;
  }
  return totalPrice;
};

for (let i = 0; i < inputGroup.length; i++) {
  const input = inputGroup[i].firstElementChild;
  const saveBtn = inputGroup[i].lastElementChild;

  saveBtn.addEventListener("click", () => {
    const itemPrice = itemSubTotal[i].previousElementSibling.innerHTML;
    console.log(itemPrice);
    console.log(i);
    console.log(input.value);
    console.log(itemPrice * input.value);
    itemSubTotal[i].innerHTML = itemPrice * input.value;
    total.innerHTML = calculateTotal();
  });
}
