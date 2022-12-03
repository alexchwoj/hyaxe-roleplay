//#pragma option -a

#define RUN_TESTS

#include <a_samp>
#include <YSI_Core\y_testing>
#include "indirection"

new gCall = 0;

forward TestCallback3(a, arr[], size);

stock TestCallbackX(n, ...)
{
	ASSERT_EQ(numargs(), n + 1);
	gCall = 100;
}

stock TestCallbackV()
{
	ASSERT_EQ(numargs(), 0);
	gCall = 101;
}
#define CALL@TestCallbackV%8() TestCallbackV%8()

static TestCallback0(a, b, c)
{
	ASSERT_EQ(numargs(), 3);
	gCall = a * b * c;
}

static TestCallback1(a, b, c)
{
	ASSERT_EQ(numargs(), 3);
	gCall = a + b + c;
}

static stock TestCallback2(a, const string:s[], d)
{
	ASSERT_EQ(numargs(), 3);
	ASSERT_SAME(s, "Hello World");
	ASSERT_NE(s[0], '\0');
	gCall = a * d;
}
#define CALL@TestCallback2%8() TestCallback2%8(0,"",0)

static TestCallback4(a, &b, c)
{
	ASSERT_EQ(numargs(), 3);
	gCall = a + b + c;
	--b;
}

public TestCallback3(a, arr[], size)
{
	ASSERT_EQ(numargs(), 3);
	ASSERT_EQ(a, size);
	gCall = arr[0] + arr[1];
}

TestCall1(Func:func<iii>, a, b, c)
{
	@.func(a, b, c);
}
#define TestCall1(&%0,%1) TestCall1(addressof(%0<iii>),%1)

TestCallArray1(Func:func<iii>, a, b, c)
{
	new
		arr[3];
	arr[0] = ref(a);
	arr[1] = ref(b);
	arr[2] = ref(c);
	Indirect_Array(_:func, tagof (func), arr);
}
#define TestCallArray1(&%0,%1) TestCallArray1(addressof(%0<iii>),%1)

TestCallArray2(Func:func<ivi>, a, &b, c)
{
	new
		arr[3];
	arr[0] = ref(a);
	arr[1] = ref(b);
	arr[2] = ref(c);
	Indirect_Array(_:func, tagof (func), arr);
}
#define TestCallArray2(&%0,%1) TestCallArray2(addressof(%0<ivi>),%1)

TestCall2(Func:func<isi>, a, d)
{
	@.func(a, "Hello World", d);
}

TestCall3(Func:func<iai>, a, arr[], size)
{
	@.func(a, arr, size);
}

@test() Indirect1()
{
	gCall = 0;
	TestCall1(&TestCallback0, 4, 5, 6);
	ASSERT_EQ(gCall, 120);
	gCall = 0;
	TestCall1(&TestCallback1, 4, 5, 6);
	ASSERT_EQ(gCall, 15);
}

@test() Indirect2()
{
	gCall = 0;
	TestCall2(Func:addressof(TestCallback2)<isi>, 99, 100);
	ASSERT_EQ(gCall, 9900);
}

@test() Indirect3()
{
	new arr[4] = { 5, 55, 555, 5555 };
	gCall = 0;
	TestCall3(Func:Indirect_Ref("TestCallback3")<iai>, 4, arr, sizeof (arr));
	ASSERT_EQ(gCall, 60);
}

@test() IndirectX()
{
	@.&TestCallbackX<ix>(10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
}

@test() IndirectV()
{
	@.&TestCallbackV();
	ASSERT(TRUE);
}

@test() IndirectArray()
{
	TestCallArray1(&TestCallback1, 9, 9, 9);
	ASSERT_EQ(gCall, 27);
	new
		a = 8;
	TestCallArray2(&TestCallback4, 9, a, 7);
	ASSERT_EQ(gCall, 24);
	ASSERT_EQ(a, 7);
	TestCallArray2(&TestCallback4, 9, a, 7);
	ASSERT_EQ(gCall, 23);
	ASSERT_EQ(a, 6);
	TestCallArray2(&TestCallback4, 9, a, 7);
	ASSERT_EQ(gCall, 22);
	ASSERT_EQ(a, 5);
}

@test(.run = false) Indirection()
{
	new str[32];
	Indirect_Call(0, 0);
	Indirect_Array(0, 0, "", 0);
	Indirect_Callstring(0, 0);
	Indirect_Callvoid(0, 0);
	Indirect_Claim(0);
	Indirect_Release(0);
	Indirect_Tag(0, str);
	new
		Func:a<iii> = addressof (TestCallback1<iii>);
	@.a(0, 0, 0);
	@.&TestCallback1<iii>(0, 0, 0);
}

static
	gTestVar1,
	gTestVar2,
	gTestVar3,
	gTestVar4;

forward OnPublicIndirectionTest(a, Float:b, const c[], d);
public OnPublicIndirectionTest(a, Float:b, const c[], d)
{
	//printf("meta: %d", INDIRECTION_COUNT);
	new meta;
	if (Indirect_GetMetaInt(0, meta))
		gTestVar1 = a + meta;
	else
		gTestVar1 = a;
	if (Indirect_GetMetaInt(1, meta))
		gTestVar2 = (_:b) + meta;
	else
		gTestVar2 = _:b;
	gTestVar3 = strval(c);
	gTestVar4 = d;
}

#define ALS_DO_PublicIndirectionTest<%1> %1<PublicIndirectionTest,ifsi>()
#define CALL@OnPublicIndirectionTest%8() OnPublicIndirectionTest%8(0, 0.0, "", 0)

@test() OnPublicIndirectionTest()
{
	gTestVar1 = 100;
	gTestVar2 = 100;
	gTestVar3 = 100;
	gTestVar4 = 100;
	@.&OnPublicIndirectionTest[2](5, 6.0, "7", 8);
	ASSERT_EQ(gTestVar1, 5 + 2);
	ASSERT_EQ(gTestVar2, _:(6.0));
	ASSERT_EQ(gTestVar3, 7);
	ASSERT_EQ(gTestVar4, 8);
	gTestVar1 = 200;
	gTestVar2 = 200;
	gTestVar3 = 200;
	gTestVar4 = 200;
	@.&OnPublicIndirectionTest<ifsi>[5, 6](5, 6.0, "7", 8);
	ASSERT_EQ(gTestVar1, 10);
	ASSERT_EQ(gTestVar2, _:(6.0) + 6);
	ASSERT_EQ(gTestVar3, 7);
	ASSERT_EQ(gTestVar4, 8);
	gTestVar1 = 300;
	gTestVar2 = 300;
	gTestVar3 = 300;
	gTestVar4 = 300;
	@.&OnPublicIndirectionTest<ifsi>(5, 6.0, "7", 8);
	ASSERT_EQ(gTestVar1, 5);
	ASSERT_EQ(gTestVar2, _:(6.0));
	ASSERT_EQ(gTestVar3, 7);
	ASSERT_EQ(gTestVar4, 8);
	gTestVar1 = 400;
	gTestVar2 = 400;
	gTestVar3 = 400;
	gTestVar4 = 400;
	@.&OnPublicIndirectionTest[1]<ifsi>(5, 6.0, "7", 8);
	ASSERT_EQ(gTestVar1, 5 + 1);
	ASSERT_EQ(gTestVar2, _:(6.0));
	ASSERT_EQ(gTestVar3, 7);
	ASSERT_EQ(gTestVar4, 8);
	gTestVar1 = 500;
	gTestVar2 = 500;
	gTestVar3 = 500;
	gTestVar4 = 500;
	@.&OnPublicIndirectionTest(5, 6.0, "7", 8);
	ASSERT_EQ(gTestVar1, 5);
	ASSERT_EQ(gTestVar2, _:(6.0));
	ASSERT_EQ(gTestVar3, 7);
	ASSERT_EQ(gTestVar4, 8);
}


